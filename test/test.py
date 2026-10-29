import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles

@cocotb.test()
async def test_project(dut):
    dut._log.info("Start ALU 74LS181 Test")

    # Αρχικοποίηση σημάτων
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0
    
    # Δημιουργία ρολογιού (αν και η ALU είναι κυρίως συνδυαστική, το TT template το απαιτεί)
    clock = Clock(dut.clk, 10, units="ns")
    cocotb.start_soon(clock.start())

    # Απελευθέρωση reset
    await ClockCycles(dut.clk, 2)
    dut.rst_n.value = 1
    await ClockCycles(dut.clk, 1)

    # -----------------------------------------------------------------
    # ΔΟΚΙΜΗ 1: Λογική Πράξη (M = 1, CNb = 1)
    # Έστω S = 4'b1010 (μεταφορά του B), A = 0xA (1010), B = 0x3 (0011)
    # Αναμενόμενο F = B = 3 (0011)
    # -----------------------------------------------------------------
    dut._log.info("Testing Logic Operation: F = B")
    
    A_val = 0xA  # 1010
    B_val = 0x3  # 0011
    S_val = 0xA  # 1010 (Επιλογή B)
    CNb_val = 1
    M_val = 1    # Λογική λειτουργία
    
    # Πακέταρε τα ui_in: [A (4 bits) | B (4 bits)]
    dut.ui_in.value = (A_val << 4) | B_val
    
    # Πακέταρε τα uio_in: [S (4 bits) | CNb (1 bit) | M (1 bit)] (ανάλογα με το mapping σου)
    dut.uio_in.value = (S_val << 2) | (CNb_val << 1) | M_val

    await ClockCycles(dut.clk, 2)

    # Το uo_out περιέχει: {F (4 bits), AEB, X, Y, CN4b}
    # Για F = 3, τα 4 MSB του uo_out θα είναι 0011 (3 << 4 = 48 δεκαδικό, συν τα flags)
    dut._log.info(f"uo_out value: {dut.uo_out.value.integer}")
    
    # Μπορείς να τσεκάρεις καθαρά τα 4 bits του F (τα 4 MSB του uo_out)
    # uo_out[7:4] είναι το F
    F_out = (dut.uo_out.value.integer >> 4) & 0xF
    assert F_out == B_val, f"Logic test failed! Expected F={B_val}, got {F_out}"

    # -----------------------------------------------------------------
    # ΔΟΚΙΜΗ 2: Αριθμητική Πράξη (M = 0, CNb = 1) - Πρόσθεση A + B
    # S = 4'b1001 (A + B)
    # -----------------------------------------------------------------
    dut._log.info("Testing Arithmetic Operation: F = A + B")
    
    S_val = 0x9  # 1001 (A + B)
    M_val = 0    # Αριθμητική λειτουργία
    CNb_val = 1  # Χωρίς carry-in (Cin = 0)

    dut.ui_in.value = (A_val << 4) | B_val
    dut.uio_in.value = (S_val << 2) | (CNb_val << 1) | M_val

    await ClockCycles(dut.clk, 2)

    # 10 + 3 = 13 (0xD)
    expected_F = (A_val + B_val) & 0xF
    F_out = (dut.uo_out.value.integer >> 4) & 0xF
    
    dut._log.info(f"A+B Result -> Expected: {expected_F}, Got: {F_out}")
    assert F_out == expected_F, f"Arithmetic test failed! Expected F={expected_F}, got {F_out}"

    dut._log.info("All ALU tests passed successfully!")
