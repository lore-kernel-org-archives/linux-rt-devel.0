Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4162B1CAA6D;
	Sat,  3 Oct 2026 07:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791011673; cv=none; b=I+Koq8aZdk7AKd+FeC0Ja9acdv1XyKOMfBOmEog9NLJ+HCk6f8ZTkTBJua0o5BivV83Y11xF1NDeAoJnQRJSDPT1EZBO4MNtIa4StZnmL64AL56tPc2qPuZFDXMH9ipdMRXsgvuhn89CAFG9C3KBfM2L9kXajXS32YSRMuGndGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791011673; c=relaxed/simple;
	bh=moR3fFjqFHyHrlH8cwjpH3MXNuwHkI5JqYMZdJzPAvE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rHNeIpSv0LbLPgriRhOo3LjP+iWZ0B2PxWkIoUoDoiW25AdvEU+Rs65V0968s9OWc1OAVvADj6ZWDno8qBIdILEeM4QBD5cNM0oWYPR86owwfhSqNO02VpSj0jQrl3C71m/yk35/Ba05SId9dARmoMMGiPxBwXN4m7syqCPpxbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZCdb6P1D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZCdb6P1D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 037F91F0089B;
	Sat,  3 Oct 2026 07:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791011671;
	bh=5tBmhEGwuY43KbJQ7GEm6cYbRCCrocod7LlYpMOYuKc=;
	h=From:Subject:Date:To:Cc;
	b=ZCdb6P1DOpGlmjsdwqKE3k0dhkW687XDkl2pzvUw3nvsYEtKyIucT5tG6Pbf899sl
	 vzUKKa+Em03kNyJqXO0e7lGg+5rH6TAkG55bJe/OwukYhK1AasLDZtCngO4jQOt2Wq
	 OmWyaIAxBLnGyCBMofnm73ZQMiN0k2EiUp68uBC0fBBryfzosSwteMr9sXXJUqpZIE
	 TU5SyxBHD4FZdCQqv+QIRgyq/vIRRCa1DUkGyRDlayIg8/W8ixbb1VaPHRAIaMfAsE
	 FJ8ZnewrWlSaXj4hc9B0mlMoRSwQZbYYxh2ApNbwRSSTWx1w2HjrrwNnNFekpQ0tpM
	 6ZT+IMpi6q7pA==
From: Drew Fustini <fustini@kernel.org>
Subject: [PATCH v9 0/5] riscv: Add initial CBQRI resctrl support
Date: Sat, 03 Oct 2026 00:12:25 -0700
Message-Id: <20261003-dfustini-atl-sc-cbqri-dt-v9-0-52fd8be98dcf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANmqwGoC/33QTU7DMBAF4KtUXmM0Hjv+YcU9EIvEHrcGlIKdR
 qCqd8cpQg2K8HKk8fc878wK5USFPezOLNOcSjqOdXB3O+YP/bgnnkKdGQJq0AJ4iKcypTHxfnr
 jxXM/fOTEw8SVAG8JjRAhsPr8PVNMn1f66flnLqfhhfy0eMvGIZXpmL+u2bNY9n5j3P8xs+DAy
 bjeGJSxH+DxlfJIb/fHvGdLzowrCVVDwiphtKBcDA5w2EhyLdmGJKvknRdSYSTp40ZSN8mAbkj
 qel3n6yqIoNVG6laSaF3XVWmAngw57yTSRtIrCVuN6yoZjzhAF5QW257MTXIgGpJZeurRyS7YT
 iNuJLuShGlIdvmT04psMDKS/SNdLpdvvoF2V9kCAAA=
X-Change-ID: 20260610-dfustini-atl-sc-cbqri-dt-410c8e2711dd
To: Adrien Ricciardi <aricciardi@baylibre.com>, 
 Alexandre Ghiti <alex@ghiti.fr>, Albert Ou <aou@eecs.berkeley.edu>, 
 Atish Patra <atish.patra@linux.dev>, Babu Moger <babu.moger@amd.com>, 
 Ben Horgan <ben.horgan@arm.com>, Borislav Petkov <bp@alien8.de>, 
 Chen Pei <cp0613@linux.alibaba.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 Dave Martin <Dave.Martin@arm.com>, Fenghua Yu <fenghuay@nvidia.com>, 
 Gong Shuai <gong.shuai@sanechips.com.cn>, Gong Shuai <gsh517@gmail.com>, 
 guo.wenjia23@zte.com.cn, James Morse <james.morse@arm.com>, 
 =?utf-8?q?Kornel_Dul=C4=99ba?= <mindal@semihalf.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, liu.qingtao2@zte.com.cn, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>, 
 Peter Newman <peternewman@google.com>, 
 =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>, 
 Reinette Chatre <reinette.chatre@intel.com>, Rob Herring <robh@kernel.org>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Tony Luck <tony.luck@intel.com>, Vasudevan Srinivasan <vasu@rivosinc.com>, 
 Ved Shanbhogue <ved@rivosinc.com>, Weiwei Li <liwei1518@gmail.com>, 
 yunhui cui <cuiyunhui@bytedance.com>, 
 Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>, 
 Drew Fustini <fustini@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 x86@kernel.org, devicetree@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
 linux-doc@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12772; i=fustini@kernel.org;
 h=from:subject:message-id; bh=moR3fFjqFHyHrlH8cwjpH3MXNuwHkI5JqYMZdJzPAvE=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWQdWB2ou6TtmPzGF1dsP4ipP50nXqrG+b0wYZ2T+LUbS
 gdcu8JdOkpZGMS4GGTFFFk2fci7sMQr9OuC+S+2wcxhZQIZwsDFKQATWb+b4X+G2wrWuXbCpyOu
 ts6cbX5O4ODGaclN6u83HVY8aG6yKfcNI8OjvCOCgi8K+Gb/sbBNZbAX9kzkWWzWkXKW43vGAau
 tXlwA
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010

This series adds initial RISC-V QoS support through the CBQRI
controller interface [1] integrated with resctrl [2], plus a DT-based
platform driver for cache controllers. It builds on the Ssqosid
extension [3] (srmcfg CSR) support that landed in v7.3 merge window.
It has been tested on both the Tenstorrent Ascalon Shared Cache
controller and a QEMU implementation [4].

  qemu-system-riscv64 -M virt,aia=aplic-imsic -nographic -m 1G -smp 8 \
      -kernel arch/riscv/boot/Image \
      -append "root=/dev/vda ro console=ttyS0 rootwait" \
      -drive if=none,file=rootfs.ext2,format=raw,id=hd0 \
      -device virtio-blk-device,drive=hd0 \
      -device riscv.cbqri.capacity,max_mcids=256,max_rcids=64,ncblks=16,mmio_base=0x04820000

Cache allocation can be exercised on the booted system. Mount resctrl
and read the default schemata. The L2 controller has 16 capacity
blocks, so the default capacity bitmask (CBM) is 0xffff:

  # mount -t resctrl resctrl /sys/fs/resctrl
  # cat /sys/fs/resctrl/schemata
  L2:0=ffff

Write a narrower CBM to a new control group and read it back to confirm
the L2 controller applied it:

  # mkdir /sys/fs/resctrl/group0
  # echo "L2:0=ff" > /sys/fs/resctrl/group0/schemata
  # cat /sys/fs/resctrl/group0/schemata
  L2:0=ff

Note that this series only implements support for resctrl L2 and L3
cache resources using CBQRI capacity allocation control. cc_block_mask
maps onto resctrl's existing cbm schema. However, cc_cunits is not
supported as there is no existing equivalent for capacity units in the
resctrl schemata.

I had previously been iterating on an RFC series [5] that did a full
implementation of CBQRI including capacity monitoring, bandwidth
allocation and monitoring. The bandwidth controls for CBQRI do not fit
well into resctrl's existing throttle-based MB schemata. I believe that
the path forward is Reinette's generic schema description proof of
concept [6]. My plan is to rebase the full support of CBQRI onto the
generic schema once it is ready.

Tony Luck's AET series [7] replaces resctrl_arch_alloc_capable() and
resctrl_arch_mon_capable() with generic helpers that walk the resources.
This series keeps the two hooks because fs/resctrl still calls them, but
now uses rdt_resource::alloc_capable.

This series is based on v7.3-rc1.

[1] https://github.com/riscv-non-isa/riscv-cbqri/releases/tag/v1.0
[2] https://docs.kernel.org/filesystems/resctrl.html
[3] https://github.com/riscv/riscv-ssqosid/releases/tag/v1.0
[4] https://github.com/tt-fustini/qemu/tree/riscv-cbqri-cache
[5] https://lore.kernel.org/linux-riscv/20260601-ssqosid-cbqri-rqsc-v7-0-v6-16-baf00f50028a@kernel.org/
[6] https://lore.kernel.org/all/d258a32f-12d5-464d-abe9-4720fb3e44b3@intel.com/
[7] https://lore.kernel.org/lkml/20260928221509.68002-1-tony.luck@intel.com/

Changes in v9:
--------------
- Drop exposed_alloc_capable and use rdt_resource::alloc_capable in
  resctrl_arch_alloc_capable().

- Read the RCID count from the resource in both the per domain init and
  the reset all path, so both read it from the same place.

- Keep every controller accepted for a cache level and look the CPU's
  cache id up in that set at online, so a controller registered after
  setup cannot back a domain without passing the capability check.

- Call resctrl_init() after cpuhp_setup_state(), so a cpuhp failure has
  no filesystem state to unwind and teardown no longer calls
  resctrl_exit().

- Pass the list position found by cbqri_find_ctrl_domain() to
  cbqri_create_ctrl_domain() so the domain list is not walked twice.

- Key the capacity controller's required properties on the generic
  riscv,cbqri-capacity-controller compatible instead of the Tenstorrent
  one to cover other vendors in the future.

- Add a comment to resctrl_arch_get_num_closid() that the CDP halving of
  num_closid is not needed for CBQRI, it only leaves the upper half of
  the RCIDs unused. Changing fs/resctrl is deferred until another
  series.

- Reject a second controller for the same cache level and cache id with
  -EEXIST, since the glue keys its domains on the cache id and would
  silently ignore it.

- Warn when cc_capabilities reads zero, so a wrong address in the DT is
  reported rather than silently skipped.

- Sort the riscv_cbqri.h include alphabetically.

- Sashiko review of v8:
  https://sashiko.dev/#/patchset/20260917-dfustini-atl-sc-cbqri-dt-v8-0-7964e8d73fe8@kernel.org

- Link to v8:
  https://patch.msgid.link/20260917-dfustini-atl-sc-cbqri-dt-v8-0-7964e8d73fe8@kernel.org

Changes in v8:
--------------
- Write cc_block_mask and cc_cunits only after the BUSY bit in
  cc_alloc_ctl reads 0. A controller that timed out on a previous
  operation and then recovered could otherwise apply the previous mask
  to the new RCID.

- Reword the cache allocation patch to say that controllers at one
  cache level must report the same number of capacity blocks, since
  resctrl exposes a single capacity mask per resource. No code change.

- Sashiko review of v7:
  https://sashiko.dev/#/patchset/20260901-dfustini-atl-sc-cbqri-dt-v7-0-ca2935d85622@kernel.org

- Link to v7:
  https://patch.msgid.link/20260901-dfustini-atl-sc-cbqri-dt-v7-0-ca2935d85622@kernel.org

Changes in v7:
--------------
- Drop the three Ssqosid patches (dt-bindings description, extension
  detection, and srmcfg CSR support). They are in mainline as of the
  v7.3 merge window, so this revision is just the CBQRI driver, the
  resctrl glue, and the CBQRI binding.

- Rebase from next-20260713 onto v7.3-rc1. The five remaining patches
  are otherwise unchanged from v6.

- Sashiko review of v6:
  https://sashiko.dev/#/patchset/20260729-dfustini-atl-sc-cbqri-dt-v6-0-7c22b05d461b@kernel.org

- Link to v6:
  https://patch.msgid.link/20260729-dfustini-atl-sc-cbqri-dt-v6-0-7c22b05d461b@kernel.org

Changes in v6:
--------------
- Introduce the RISCV_CBQRI Kconfig if/endif block in the patch that
  adds the RISCV_CBQRI_CAPACITY option it guards, rather than as an
  empty block in an earlier patch.

- Note in cbqri_probe_cc() that the 32 capacity block limit comes from
  resctrl representing the CBM as a u32.

- Sashiko review of v5:
  https://sashiko.dev/#/message/20260714-dfustini-atl-sc-cbqri-dt-v5-0-b0ae7e9c932e@kernel.org

- Link to v5:
  https://patch.msgid.link/20260714-dfustini-atl-sc-cbqri-dt-v5-0-b0ae7e9c932e@kernel.org

Changes in v5:
--------------
- Resolve control domain membership from each CPU's cache id in
  cacheinfo at hotplug, instead of a CPU mask captured at probe.

- Add and remove control domains on the ctrl_domains RCU list
  following the documented traversal rules.

- Restructure cbqri_resctrl_pick_caches() to select one controller per
  cache level, which removes the separate dropped[] array and the
  overloaded NULL controller pointer.

- Initialize the control domain's resource id.

- Drop the inaccurate comment above the stubbed resctrl_arch_*()
  operations.

- Sashiko review of v4:
  https://sashiko.dev/#/patchset/20260706-dfustini-atl-sc-cbqri-dt-v4-0-e75c20201d64@kernel.org

- Link to v4:
  https://patch.msgid.link/20260706-dfustini-atl-sc-cbqri-dt-v4-0-e75c20201d64@kernel.org

Changes in v4:
--------------
- Register the srmcfg PM notifier even if cpuhp_setup_state() fails in
  riscv_srmcfg_init(). The early return on failure had skipped it,
  dropping the srmcfg restore across suspend and resume.

- Make RISCV_CBQRI a user-selectable option that depends on
  RISCV_ISA_SSQOSID, instead of being selected unconditionally.

- Bound the per-domain control value init by the domain's own
  controller's RCID count rather than the resource wide count.

- Drop only the affected cache level when capacity controllers at the
  same level report mismatched capabilities, rather than aborting the
  whole resctrl setup.

- Use guard(mutex) instead of lock/unlock for cbqri_controllers_lock.

- Read the CBQRI control registers into low and high halves so the
  access order is explicit and comment on torn reads.

- Clarify in cbqri_resctrl_pick_caches() that the first matching leaf is
  correct for a unified shared cache.

- Link to v3:
  https://patch.msgid.link/20260628-dfustini-atl-sc-cbqri-dt-v3-0-c9c1342fe3cf@kernel.org

- Sashiko review of v3:
  https://sashiko.dev/#/patchset/20260628-dfustini-atl-sc-cbqri-dt-v3-0-c9c1342fe3cf@kernel.org

Changes in v3:
--------------
- riscv,cbqri.yaml:
  - Require a device-specific compatible so a bare generic compatible
    is no longer valid on its own.
  - Rename node name from cache-controller@ to qos-controller@
  - Rename compatible from tenstorrent,ascalon-sc-cbqri to
    tenstorrent,ascalon-shared-cache-controller

- Take cbqri_controllers_lock in cbqri_attach_cpu_to_all_ctrls() so a
  controller probed after boot can't corrupt the cbqri_controllers list.

- Revise comment above riscv_srmcfg_reset_cache() to clarify that the
  teardown callback is not relied on. The cpuhp startup callback re-arms
  the per-cpu sentinel, which forces the csr write on a re-onlined CPU.

- Drop the memory fences around the srmcfg CSR write on context switch.
  Ssqosid does not require the ordering. The brief tagging inaccuracy at
  the switch boundary is acceptable for QoS.

- Access the CBQRI controller registers with 32-bit reads and writes.
  The spec only guarantees single-copy atomicity for 4-byte accesses.
  This also removes the dependency on native 64-bit MMIO.

- Program cc_cunits to 0 before a config limit operation on controllers
  that support capacity units, so a stale unit limit does not constrain
  block-mask allocation.

- Link to v2:
  https://patch.msgid.link/20260624-dfustini-atl-sc-cbqri-dt-v2-0-2f8049fd902b@kernel.org

- Sashiko review of v2:
  https://sashiko.dev/#/patchset/20260624-dfustini-atl-sc-cbqri-dt-v2-0-2f8049fd902b@kernel.org

Changes in v2:
--------------
The changes in this revision address the Sashiko review of v1.

- Restore the srmcfg CSR for the current task on CPU_PM_EXIT and
  CPU_PM_ENTER_FAILED, so it is not left configured incorrectly until
  the next context switch.

- Serialize the cbqri_controllers list insert and the boot time walk
  with a mutex, so an asynchronous driver probe cannot corrupt the list.

- Skip a controller at an unsupported cache level instead of aborting
  resctrl setup, so valid L2 and L3 controllers still register.

- RISCV_ISA_SSQOSID selects ARCH_HAS_CPU_RESCTRL and RISCV_CBQRI
  together, so no intermediate commit enables RESCTRL_FS without the
  CBQRI resctrl glue.

- Rename the RISCV_CBQRI_DRIVER to RISCV_CBQRI, since it builds the
  CBQRI core ops and resctrl integration rather than a driver.

- Drop the RISCV_CBQRI_DRIVER_DEBUG Kconfig option and rely on dynamic
  debug to control the pr_debug() output.

- Note: Sashiko flagged the lack of suspend/resume state restore. I will
  not fix that as register state is only lost when the power domain is
  gated, which offlines the harts sharing the cache. resctrl reprograms
  the default capacity mask through the normal control domain online
  path on resume.

- Link to v1:
  https://lore.kernel.org/all/20260619-dfustini-atl-sc-cbqri-dt-v1-0-e79a7723fab0@kernel.org/

- Sashiko review of v1:
  https://sashiko.dev/#/patchset/20260619-dfustini-atl-sc-cbqri-dt-v1-0-e79a7723fab0@kernel.org

---
Drew Fustini (5):
      riscv_cbqri: Add capacity controller probe and allocation device ops
      riscv_cbqri: resctrl: Add cache allocation via capacity block mask
      riscv_cbqri: Make RESCTRL_FS available on RISC-V
      dt-bindings: riscv: Add binding for CBQRI controllers
      riscv_cbqri: Add CBQRI capacity allocation platform driver

 .../devicetree/bindings/riscv/riscv,cbqri.yaml     |  97 +++
 MAINTAINERS                                        |   7 +
 arch/riscv/include/asm/resctrl.h                   | 147 ++++
 drivers/resctrl/Kconfig                            |  30 +
 drivers/resctrl/Makefile                           |   5 +
 drivers/resctrl/cbqri_capacity.c                   | 127 ++++
 drivers/resctrl/cbqri_devices.c                    | 574 ++++++++++++++
 drivers/resctrl/cbqri_internal.h                   | 122 +++
 drivers/resctrl/cbqri_resctrl.c                    | 831 +++++++++++++++++++++
 include/linux/riscv_cbqri.h                        |  45 ++
 10 files changed, 1985 insertions(+)
---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20260610-dfustini-atl-sc-cbqri-dt-410c8e2711dd

Best regards,
--  
Drew Fustini (Tenstorrent) <fustini@kernel.org>

