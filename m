Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA6B1B4223;
	Mon,  6 Jul 2026 23:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783379187; cv=none; b=R7wXyrsCj4Q0TgMeDPDmVMJ4UP0rs+hqeY8fHv1vyHefw/b4ZPPZd2oZInseXSwPP7T3vtnZtuHlHSUsGOMKTMEi0Bli/NkX+gRhM7tP8Uwgb0O6QgraxtJKGBxilVk9TPzO9mv7+i4hXzMwkwdKFd9nDtSdiq4aQyPi8mOIkLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783379187; c=relaxed/simple;
	bh=dCJaDc8KZE/65mD7ajpQ54L19BvFoQaGNIoZaZXA+D8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MZCYhnMgFn11Srj3raDKjsXrX0FrztlIIErbC6EMyeUT+Y5nD7H7t8n3Tu1v+L+kcA2Mltx94ipFXM0zl0dwU6Rl7SyOx+pm0yhpT4CVrwHyvhdcseT08C+g39aRs/Qbjqr9xKdmMt77ddo4BhjgwtZ/nfgxBIYdPEhRY1tniJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cW9x2RuN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cW9x2RuN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E3091F00A3A;
	Mon,  6 Jul 2026 23:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783379185;
	bh=loMgTZpePsF9KMdRZN70LHEU2IXFn9IqbgZFaI7Yd6w=;
	h=From:Subject:Date:To:Cc;
	b=cW9x2RuNDm10C8C/czQTw8poN3fkLGUkL18cPI1WNjRIU5ogN9rZanRKB+RQFRWe3
	 UmAG+3d7FIV2n43RByZKiTsSmDQ3bs/ACouVRyixLPYz0zZGDeLu5Fe3rncG4KmcQQ
	 uXRYTwtzjBHS2uUl5YzCfQg74BDZZ8TUsn+vcVID3B4UuA+jmvdNzE4a7MsZHkEnix
	 pyB9CsH3V4d4fhSE3WGROEA+QB8JP4dCnnSYMzzxPkka3G5he8TJJaVgMc3a+ZBZIs
	 qKo4z25r6nNPssXL/csnQ8+5+39I8tWHJ/BkfIXITCwRL0rxOGP8fZit5TOo4ucUOa
	 SjZ7Nl6kYWi+Q==
From: Drew Fustini <fustini@kernel.org>
Subject: [PATCH v4 0/8] riscv: Add Ssqosid and initial CBQRI resctrl
 support
Date: Mon, 06 Jul 2026 16:06:10 -0700
Message-Id: <20260706-dfustini-atl-sc-cbqri-dt-v4-0-e75c20201d64@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOM0TGoC/33NwYrCMBDG8VeRnB1JJqFtPPkei4c2mejsSusms
 bhI333TyoKL6PGDmd//JhJFpiS2q5uINHLioS/DrFfCHdv+QMC+bIESK1kpCT5cUuaeoc0nSA5
 c9x0ZfAajpGsIa6W8F+X9HCnwdaE/9vedLt0nuTx788WRUx7iz9Ie1Xz3l7GvM6MCCVTbtq5Rh
 7aTuy+KPZ02QzyIuTPig4TmjYRFwtBIY4O3ErsnST9KzRtJF8lZp7TBQNqFf9I0Tb/2y1UqZwE
 AAA==
X-Change-ID: 20260610-dfustini-atl-sc-cbqri-dt-410c8e2711dd
To: Adrien Ricciardi <aricciardi@baylibre.com>, 
 Alexandre Ghiti <alex@ghiti.fr>, Atish Kumar Patra <atishp@rivosinc.com>, 
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
 Tony Luck <tony.luck@intel.com>, Vasudevan Srinivasan <vasu@rivosinc.com>, 
 Ved Shanbhogue <ved@rivosinc.com>, Weiwei Li <liwei1518@gmail.com>, 
 yunhui cui <cuiyunhui@bytedance.com>, Drew Fustini <fustini@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 x86@kernel.org, devicetree@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
 linux-doc@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8705; i=fustini@kernel.org;
 h=from:subject:message-id; bh=dCJaDc8KZE/65mD7ajpQ54L19BvFoQaGNIoZaZXA+D8=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWT5mDyT6S9XPCJ4Jvwnx1HpYBtDvyeb+ecw5uuFdIY95
 s12WlvRUcrCIMbFICumyLLpQ96FJV6hXxfMf7ENZg4rE8gQBi5OAZjIv+cM/2v/V4Qs5Par7lJI
 CBb0npFht9PiYOzaDaoPM9QeXfH5+5XhN8sS/Ui5K5ILnt/M9F/cucDZY1KDSjT3ZsbDkzUipu4
 6yQIA
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010

This series adds initial RISC-V QoS support: the Ssqosid extension [1]
(srmcfg CSR), the CBQRI controller interface [2] integrated with resctrl
[3], and a DT-based platform driver for cache controllers. It has been
tested on both the Tenstorrent Ascalon Shared Cache controller and a QEMU
implementation [4].

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

This series is based on the linux-next tag next-20260706.

[1] https://github.com/riscv/riscv-ssqosid/releases/tag/v1.0
[2] https://github.com/riscv-non-isa/riscv-cbqri/releases/tag/v1.0
[3] https://docs.kernel.org/filesystems/resctrl.html
[4] https://github.com/tt-fustini/qemu/tree/riscv-cbqri-cache
[5] https://lore.kernel.org/linux-riscv/20260601-ssqosid-cbqri-rqsc-v7-0-v6-16-baf00f50028a@kernel.org/
[6] https://lore.kernel.org/all/aab804b9-e8b5-40ad-a85b-af7033391243@intel.com/

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
Drew Fustini (8):
      dt-bindings: riscv: Add Ssqosid extension description
      riscv: Detect the Ssqosid extension
      riscv: Add support for srmcfg CSR from Ssqosid extension
      riscv_cbqri: Add capacity controller probe and allocation device ops
      riscv_cbqri: resctrl: Add cache allocation via capacity block mask
      riscv: Enable resctrl filesystem for Ssqosid
      dt-bindings: riscv: Add binding for CBQRI controllers
      riscv_cbqri: Add CBQRI capacity allocation platform driver

 .../devicetree/bindings/riscv/extensions.yaml      |   6 +
 .../devicetree/bindings/riscv/riscv,cbqri.yaml     |  97 +++
 MAINTAINERS                                        |  15 +
 arch/riscv/Kconfig                                 |  18 +
 arch/riscv/include/asm/csr.h                       |   5 +
 arch/riscv/include/asm/hwcap.h                     |   1 +
 arch/riscv/include/asm/processor.h                 |   3 +
 arch/riscv/include/asm/qos.h                       |  74 ++
 arch/riscv/include/asm/resctrl.h                   | 147 ++++
 arch/riscv/include/asm/switch_to.h                 |   3 +
 arch/riscv/kernel/Makefile                         |   2 +
 arch/riscv/kernel/cpufeature.c                     |   1 +
 arch/riscv/kernel/qos.c                            | 101 +++
 drivers/resctrl/Kconfig                            |  31 +
 drivers/resctrl/Makefile                           |   5 +
 drivers/resctrl/cbqri_capacity.c                   | 137 ++++
 drivers/resctrl/cbqri_devices.c                    | 570 +++++++++++++++
 drivers/resctrl/cbqri_internal.h                   | 124 ++++
 drivers/resctrl/cbqri_resctrl.c                    | 788 +++++++++++++++++++++
 include/linux/riscv_cbqri.h                        |  47 ++
 20 files changed, 2175 insertions(+)
---
base-commit: 8e9685d3c41c35dd1b37df70d854137abcb2fbac
change-id: 20260610-dfustini-atl-sc-cbqri-dt-410c8e2711dd

Best regards,
--  
Drew Fustini <fustini@kernel.org>

