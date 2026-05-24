Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8615135B63D;
	Sun, 24 May 2026 23:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779667053; cv=none; b=DLUIgaFJSp1W2x9I2N+Y3UvxR+t/6Q985b4s1oGO44XMuC0F1YINSzLY5zvfZU50Cdq4iAg66XxuHCuVFeKbanUPGMyKqkPpmufreqsotjzqqj4IcPnvyn21ilFnOPYmGY2Rb3NmMwlaF2n0udbMZ/dso9/1E+LJOU6TpjTmrvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779667053; c=relaxed/simple;
	bh=sz5OPDUjPWf+fjFYdTra0iSImEHV8433iNG0FX3uL3Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FRtURBSIZ89f6dzhaHi/la+hqi9r13zhAs42kECBItIl3jA0pFw7inZuoiasK3oA6fpn2avwOJq/0Do6hQqSZVJwb1z1xbiWxpalcvEx8cMoVQGHQptEIu+X2tLpCmkDT7jSiDEsztc6Mte9vMOIJj83sa8tro+2mOP3OGt5Vtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c4WpHs28; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c4WpHs28"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57E361F000E9;
	Sun, 24 May 2026 23:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779667051;
	bh=FNEnb3a82Lv1ruIE8fCcn6k/DdqaeL/OiA6Qu9ctWYQ=;
	h=From:Subject:Date:To:Cc;
	b=c4WpHs28mKHrEJRAP3Sp+a75C1/Vcpmx8i5TZwrujzDiorX4K/iyVB7A+7isXG+FW
	 FOWIkaR8cZsYJrBD6dlLdafqZu6ei4p1mbeuO10gkKPquY+oqMBAg/zWC+vYbdQcZk
	 Hg22+0PbVkXOZ0TQlw9mR8h33MMz7H3VX7IXqe5/nETjLqdQeoSXtFqZ8pMSuvHpbd
	 mV/rtB96rPqMS0i9eUaU6yHNekmBDEBFKMd2MgtSTEcoLhehdwcZOJ91WXZN42WswK
	 q5cLwpVFoDfkB7kcAbqHWbX9jAg2Dn71CFZauReo3daXPbsxqk1PtD/3xc8R2uKHob
	 /3zqYmSKCEfKA==
From: Drew Fustini <fustini@kernel.org>
Subject: [PATCH RFC v5 00/18] riscv: add Ssqosid and CBQRI resctrl support
Date: Sun, 24 May 2026 16:55:30 -0700
Message-Id: <20260524-ssqosid-cbqri-rqsc-v7-0-v5-0-78d3a7ba9dbe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPKPE2oC/3XNsQrCMBAG4FcpNxtJm7SJToLgA7iKQ5Je26A0N
 pGglL67MYs4dDn47+e+myGgtxhgX8zgMdpg3ZhCvSnADGrskdg2Zaho1VBW7UgIkwu2JUZP3hI
 /BUOiIJRoaoSUWmkuFaTrh8fOvrJ8gfPpCNe0HGx4Ov/O3yLLVYZ5yVfhyL460xUK3Eku1OGGf
 sT71vk+o5H/oLqk6xBPA3XNJCuxayT7g5Zl+QB2piFrDQEAAA==
X-Change-ID: 20260329-ssqosid-cbqri-rqsc-v7-0-b0c788bab48a
To: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Adrien Ricciardi <aricciardi@baylibre.com>, 
 Nicolas Pitre <npitre@baylibre.com>, 
 =?utf-8?q?Kornel_Dul=C4=99ba?= <mindal@semihalf.com>, 
 Atish Patra <atish.patra@linux.dev>, 
 Atish Kumar Patra <atishp@rivosinc.com>, 
 Vasudevan Srinivasan <vasu@rivosinc.com>, Ved Shanbhogue <ved@rivosinc.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 yunhui cui <cuiyunhui@bytedance.com>, Chen Pei <cp0613@linux.alibaba.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Weiwei Li <liwei1518@gmail.com>, 
 guo.wenjia23@zte.com.cn, Gong Shuai <gong.shuai@sanechips.com.cn>, 
 Gong Shuai <gsh517@gmail.com>, liu.qingtao2@zte.com.cn, 
 Reinette Chatre <reinette.chatre@intel.com>, 
 Tony Luck <tony.luck@intel.com>, Babu Moger <babu.moger@amd.com>, 
 Peter Newman <peternewman@google.com>, Fenghua Yu <fenghua.yu@intel.com>, 
 James Morse <james.morse@arm.com>, Ben Horgan <ben.horgan@arm.com>, 
 Dave Martin <Dave.Martin@arm.com>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>, Sunil V L <sunilvl@ventanamicro.com>, 
 Drew Fustini <fustini@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 x86@kernel.org, linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
 devicetree@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>, 
 Conor Dooley <conor@kernel.org>, linux-rt-devel@lists.linux.dev, 
 linux-doc@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=13278; i=fustini@kernel.org;
 h=from:subject:message-id; bh=sz5OPDUjPWf+fjFYdTra0iSImEHV8433iNG0FX3uL3Q=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWQJT0i+UJxdX+V77MnECZ9dtjzZWNTbOWXPzVVBB5m0m
 dYyGdc86yhlYRDjYpAVU2TZ9CHvwhKv0K8L5r/YBjOHlQlkCAMXpwBMZOcdRoYFNbGnEz5P2t/W
 FOizu7pqXbD7yxeHVx9fLrlXNd1ss04kI0OfzIY2mZ1RLus5Ev+m7eGJ4c4Lurn0bVwV15rlN4r
 vXmcFAA==
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010

This RFC series adds RISC-V QoS support: the Ssqosid extension [1]
(srmcfg CSR), the CBQRI controller interface [2] integrated with
resctrl [3], and ACPI RQSC [4] for controller discovery. DT support
is possible but no platform drivers are included. The series is
also available as a branch [5].

QEMU support for Ssqosid and CBQRI lives in [6], with ACPI RQSC as
a follow-on series [7]. There is also a combined branch [8].

Series organization
-------------------
01      DT binding for Ssqosid extension
02-03   Ssqosid ISA support (detection, srmcfg CSR, switch_to)
04-06   fs/resctrl helpers and resource type additions
07-10   CBQRI device ops (cbqri_devices.c): capacity probe +
        allocation, capacity monitoring, bandwidth probe +
        allocation, bandwidth monitoring
11-15   CBQRI resctrl integration (cbqri_resctrl.c): cache
        allocation, L3 cache occupancy monitoring, MB_MIN
        bandwidth allocation, MB_WGHT bandwidth allocation,
        mbm_total_bytes monitoring
16-17   ACPI RQSC parser and init
18      Enable resctrl filesystem for Ssqosid (Kconfig)

Refer to the v3 cover letter [9] for the test setup including the
reference SoC layout and the corresponding QEMU command line.

[1] https://github.com/riscv/riscv-ssqosid/releases/tag/v1.0
[2] https://github.com/riscv-non-isa/riscv-cbqri/releases/tag/v1.0
[3] https://docs.kernel.org/filesystems/resctrl.html
[4] https://github.com/riscv-non-isa/riscv-rqsc/blob/main/src/
[5] https://git.kernel.org/pub/scm/linux/kernel/git/fustini/linux.git/log/?h=b4/ssqosid-cbqri-rqsc
[6] https://lore.kernel.org/qemu-devel/20260105-riscv-ssqosid-cbqri-v4-0-9ad7671dde78@kernel.org/
[7] https://lore.kernel.org/qemu-devel/20260202-riscv-rqsc-v1-0-dcf448a3ed73@kernel.org/
[8] https://github.com/tt-fustini/qemu/tree/b4/riscv-rqsc
[9] https://lore.kernel.org/r/20260414-ssqosid-cbqri-rqsc-v7-0-v3-0-b3b2e7e9847a@kernel.org

Key design decisions
--------------------
- Create new resource types as RDT_RESOURCE_MBA cannot represent the
  semantics of the CBQRI bandwidth controllers:

  - RDT_RESOURCE_MB_MIN matches CBQRI Rbwb (reserved bandwidth
    blocks). The sum of Rbwb across all control groups must be
    <= MRBWB (maximum number of reserved bandwidth blocks).

  - RDT_RESOURCE_MB_WGHT matches CBQRI Mweight, the weighted share of
    the remaining bandwidth blocks. Values are in [0, 255]: 0 disables
    work-conserving sharing for the group, 1..255 compete for the
    leftover pool.

- mbm_total_bytes is supported only when the platform exposes exactly
  one mon-capable bandwidth controller and exactly one L3 domain.
  Pairing a single BC across multiple L3 domains would let standard
  userspace tools overcount system bandwidth by summing the same
  counter across domains.

Open issues
-----------
 - RDT_RESOURCE_MB_MIN and RDT_RESOURCE_MB_WGHT are intended to drive
   discussion, not as the final solution. I plan to rebase onto
   Reinette's proof of concept once it is posted.

 - resctrl monitoring scope limitations:
   - monitor-only L3 capacity controllers are not supported.
   - CBQRI capacity controllers can monitor any cache level, but resctrl
     only supports occupancy on L3.
   - resctrl needs to gain a non-CPU scope level for mbm_total_bytes
     to be supported on platforms with multiple bandwidth controllers
     or multiple L3 domains.

 - When a control group is freed, rbwb_cache[closid] is not reset,
   so the MB_MIN sum check can count the stale reservation against
   MRBWB. Fixing this requires a new resctrl_arch_* callback in
   fs/resctrl invoked on group destroy, which is out of scope for
   this arch-driver series.

 - cc_cunits is not supported. cc_block_mask maps well onto resctrl's
   existing CBM schema, but there is no existing equivalent for
   capacity units.

 - RQSC structs live in drivers/acpi/riscv/rqsc.h until the spec is
   ratified and the ACPICA upstream submission lands. They will then move
   to include/acpi/actbl2.h. The spec is in the final phase
   before ratification.

Changes in v5:
--------------
The changes in this revision are based on the feedback in the Sashiko
review of the series.

Ssqosid:
 - Seed cpu_srmcfg to U32_MAX in DEFINE_PER_CPU so early-boot context
   switches always write the CSR rather than matching a zero-initialised
   cache before riscv_srmcfg_init() runs.
 - __switch_to_srmcfg() evaluates RCID and MCID against
   cpu_srmcfg_default independently. A task in the default RCID group
   with a specific MCID previously bypassed the CPU default.
 - Register a CPU PM notifier that invalidates cpu_srmcfg on
   CPU_PM_EXIT / CPU_PM_ENTER_FAILED so resume-from-suspend on the boot
   CPU writes the CSR.
 - Drop the for_each_online_cpu pre-seed loop in riscv_srmcfg_init().
   cpuhp_setup_state() already covers already-online CPUs.

CBQRI:
 - Add mweight_cache. cbqri_apply_bc_field() seeds both fields of
   bc_bw_alloc from the software caches, so that stale data can not leak
   into the unmodified field.
 - Seed mweight_cache to FIELD_MAX(MWEIGHT_MASK) at probe so the first
   MB_MIN domain init does not commit Mweight=0 to every RCID. A weight
   of 0 is a hard cap on opportunistic bandwidth, which would starve
   every RCID until the subsequent MB_WGHT domain init catches up.
 - cbqri_apply_mweight_config() rejects mweight > WEIGHT_MASK at entry
   rather than letting it truncate and trigger a verify mismatch.
 - cbqri_apply_bc_field() updates per-RCID cache only after verifying.
 - cbqri_controller_destroy() now iounmaps and releases the mem region
   from rollback paths, gated on ctrl->base.
 - cbqri_probe_feature() clears OP, AT, RCID and EVT_ID on every write,
   so the probe never writes stale bits into the register.
 - cbqri_apply_cache_config() clears cc_block_mask before the initial
   READ_LIMIT that captures saved_cbm.
 - Drop the ctrl->faulted early return from controller ops.
 - Reject a second bandwidth controller when sharing a proximity domain.
 - Rejects ctrl->rcid_count > SRMCFG_RCID_MASK so the schedule-in
   fast path cannot silently truncate the RCID.
 - Widen CBQRI_MON_CTL_OP/MCID/EVT_ID masks to GENMASK_ULL so
   FIELD_MODIFY on a u64 register stays safe if RV32 support is added.

resctrl:
 - Switch the L3 mon_domain teardown paths from cancel_delayed_work_sync
   to cancel_delayed_work to avoid potential deadlock.
 - Guard the mbm_over cancel on QOS_L3_MBM_TOTAL_EVENT_ID, so a system
   without a paired BC does not cancel a zeroed work struct.
 - cbqri_attach_cpu_to_cap_ctrl() rolls back cpumask_set_cpu and any
   freshly created ctrl_domain when cbqri_attach_cpu_to_l3_mon() fails.
 - Restrict mbm_total_bytes to platforms with exactly one L3 domain.
 - Pair the L3 mon domain with its BC and initialise the BC's
   per-MCID accumulators before resctrl_online_mon_domain() exposes
   the domain, so a concurrent mbm_total_bytes read cannot race with
   paired_bc init.
 - Hold cbqri_domain_list_lock across the MMIO paths in
   resctrl_arch_rmid_read() and resctrl_arch_reset_rmid() so a
   concurrent CPU hotplug detach cannot free hw_dom mid-read.
 - cbqri_resctrl_setup() rolls back exposed_alloc_capable /
   exposed_mon_capable on resctrl_init() failure so
   resctrl_arch_*_capable() does not report stale state to callers.
 - Drop the cacheinfo_ready wait queue in cbqri_resctrl_setup() and
   the RCU annotations on the ctrl_domain list. cacheinfo runs at
   device_initcall_sync, strictly before late_initcall, and the list
   is mutated only from cpuhp callbacks under cbqri_domain_list_lock.

Kconfig:
 - RISCV_ISA_SSQOSID selects RISCV_CBQRI_DRIVER unconditionally. resctrl
   is gated separately by the silent RISCV_CBQRI_RESCTRL_FS option. 

ACPI:
 - acpi_parse_rqsc() rejects tables with the wrong header.revision,
   validates res0->type and res0->id_type, and checks that node->length
   does not overrun the table end.

Sashiko review:
https://sashiko.dev/#/patchset/20260510-ssqosid-cbqri-rqsc-v7-0-v4-0-eb53831ef683%40kernel.org

Link to v4:
https://lore.kernel.org/all/20260510-ssqosid-cbqri-rqsc-v7-0-v4-0-eb53831ef683@kernel.org/

Changes in v4:
--------------
resctrl:
 - Add RDT_RESOURCE_MB_MIN and RDT_RESOURCE_MB_WGHT
 - Add default_to_min to resctrl_membw so MB_MIN defaults to min_bw
 - Add L3 cache occupancy monitoring for L3-scoped capacity controllers
 - Add mbm_total_bytes bandwidth monitoring when there is a single
   bandwidth controller
 - Move domain creation into cpuhp callbacks so that cpu_mask reflects
   only online CPUs
 - resctrl_arch_reset_rmid() returns early when called with IRQs
   disabled.

CBQRI:
 - Replace per-controller spinlock with mutex. Each CBQRI op is a
   write-then-poll-busy cycle of up to 1 ms. A sleeping mutex paired
   with readq_poll_timeout() keeps preemption enabled across the
   busy-wait. All resctrl-arch entry points run in process context.
 - Replace struct cbqri_config with direct params in helper functions.
 - max_rmid = min(max_rmid, ctrl->mcid_count) now gated on
   ctrl->mon_capable.
 - Validate that the sum of Rbwb does not exceed MRBWB.
 - Move CDP enable state from file-scope globals to per-resource
   cdp_enabled / cdp_capable.
 - Configure both AT_CODE and AT_DATA limits when CDP is supported but
   not enabled.

Ssqosid:
 - __switch_to_srmcfg() emits RISCV_FENCE(rw, o) before and (o, rw)
   after csrw to drain old-task stores and order new-task loads.
 - Invalidate per-cpu cpu_srmcfg on hart online via CPUHP_AP_ONLINE_DYN.
   Also seed already-online CPUs synchronously at init.

ACPI:
 - Drop the PPTT helper patch and resolve cache_size via cacheinfo at
   cbqri_resctrl_setup() time.
 - ACPI driver now calls riscv_cbqri_register_controller() and the
   cbqri_controller internals stay in cbqri_internal.h.

Refer to v3 for previous change logs:
https://lore.kernel.org/r/20260414-ssqosid-cbqri-rqsc-v7-0-v3-0-b3b2e7e9847a@kernel.org

---
Drew Fustini (18):
      dt-bindings: riscv: Add Ssqosid extension description
      riscv: detect the Ssqosid extension
      riscv: add support for srmcfg CSR from Ssqosid extension
      fs/resctrl: Add resctrl_is_membw() helper
      fs/resctrl: Add RDT_RESOURCE_MB_MIN and RDT_RESOURCE_MB_WGHT
      fs/resctrl: Let bandwidth resources default to min_bw at reset
      riscv_cbqri: Add capacity controller probe and allocation device ops
      riscv_cbqri: Add capacity controller monitoring device ops
      riscv_cbqri: Add bandwidth controller probe and allocation device ops
      riscv_cbqri: Add bandwidth controller monitoring device ops
      riscv_cbqri: resctrl: Add cache allocation via capacity block mask
      riscv_cbqri: resctrl: Add L3 cache occupancy monitoring
      riscv_cbqri: resctrl: Add MB_MIN bandwidth allocation via Rbwb
      riscv_cbqri: resctrl: Add MB_WGHT bandwidth allocation via Mweight
      riscv_cbqri: resctrl: Add mbm_total_bytes bandwidth monitoring
      ACPI: RISC-V: Parse RISC-V Quality of Service Controller (RQSC) table
      ACPI: RISC-V: Add support for RISC-V Quality of Service Controller (RQSC)
      riscv: enable resctrl filesystem for Ssqosid

 .../devicetree/bindings/riscv/extensions.yaml      |    6 +
 MAINTAINERS                                        |   15 +
 arch/riscv/Kconfig                                 |   20 +
 arch/riscv/include/asm/acpi.h                      |   10 +
 arch/riscv/include/asm/csr.h                       |    5 +
 arch/riscv/include/asm/hwcap.h                     |    1 +
 arch/riscv/include/asm/processor.h                 |    3 +
 arch/riscv/include/asm/qos.h                       |   87 ++
 arch/riscv/include/asm/resctrl.h                   |  152 ++
 arch/riscv/include/asm/switch_to.h                 |    3 +
 arch/riscv/kernel/Makefile                         |    2 +
 arch/riscv/kernel/cpufeature.c                     |    1 +
 arch/riscv/kernel/qos.c                            |   84 ++
 drivers/acpi/riscv/Makefile                        |    1 +
 drivers/acpi/riscv/init.c                          |   21 +
 drivers/acpi/riscv/rqsc.c                          |  194 +++
 drivers/acpi/riscv/rqsc.h                          |   63 +
 drivers/resctrl/Kconfig                            |   32 +
 drivers/resctrl/Makefile                           |    6 +
 drivers/resctrl/cbqri_devices.c                    | 1100 +++++++++++++++
 drivers/resctrl/cbqri_internal.h                   |  246 ++++
 drivers/resctrl/cbqri_resctrl.c                    | 1458 ++++++++++++++++++++
 fs/resctrl/ctrlmondata.c                           |    3 +-
 fs/resctrl/internal.h                              |    2 +
 fs/resctrl/rdtgroup.c                              |   16 +-
 include/linux/resctrl.h                            |   13 +-
 include/linux/riscv_cbqri.h                        |   66 +
 27 files changed, 3601 insertions(+), 9 deletions(-)
---
base-commit: 5200f5f493f79f14bbdc349e402a40dfb32f23c8
change-id: 20260329-ssqosid-cbqri-rqsc-v7-0-b0c788bab48a

Best regards,
--  
Drew Fustini <fustini@kernel.org>

