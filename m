Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DA8800;
	Sun, 28 Jun 2026 21:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782681526; cv=none; b=FK4tKVhtocR8nT6DMhVfKsXB5pzyZj608T9eG0I9RtL8zduWjgpQFSIZQCo7XAZlrcVsMHhCygWR6Cu54X6T8WDFeghbH9krjaJE+SoC6osX3LJNIMoHeLkDln5+lTOVhJG7J3jcM1EfhBDXGm6H40BYOPaiyoqtswuXGCQA3Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782681526; c=relaxed/simple;
	bh=llCgYXXJQ5bOYICf9djgNzfbgXeNPCTj/ihuuFFOj10=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=A4HAHgCLKd9A7zJ/VFcqOKIPW/Q9aNb378ljMd/YVVffjDBte8pJY9pP1s5PxtjZJvdGunWKk0nM4C1cOYSDiWwyBrhD0dElgT8eifJeexcG7DPdqmunkzEUIIZjpdpZ1aJP9YPql8+YFKC5zqm4Eb0cIK3ADZ7eX3HWYtvBa58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AWSxr8Z6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AWSxr8Z6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE5471F000E9;
	Sun, 28 Jun 2026 21:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782681524;
	bh=HyCs9ijfBF0ZUElYT55/Qos5tui3tyiLjbIjL4guzbE=;
	h=From:Subject:Date:To:Cc;
	b=AWSxr8Z6fddnPkUYcxp/duFh4LsV9vb26X0DZ9AsCXNjjg8f4HGIQQ7p8LdKgznaN
	 EWVTnqx1nhpHZ5vzrADGsavmMjCEdrt9LtQ04a57im4o9i4HVt0pBWtHofmAu7w6hl
	 cTZkv1b41lUuHx6VKnZEuHG70ZsOasH5sxFw82S2QcW8ri5WGm8dvDuZryIA6crrXp
	 6+T8/Qvp+sCgnwDlwTrqbum+9Gh+XSfA/XsbUouxQSWnqZJvzDDESzTto3Y0XYaVkO
	 Bq8BEO31TV4cJQdtCPF1XpYFUmI85d0zFVZnsGQn6nD/VSE481pjhMCnAuicWPqrd+
	 6k0P+NhyFUMLw==
From: Drew Fustini <fustini@kernel.org>
Subject: [PATCH v3 0/8] riscv: Add Ssqosid and initial CBQRI resctrl
 support
Date: Sun, 28 Jun 2026 14:18:11 -0700
Message-Id: <20260628-dfustini-atl-sc-cbqri-dt-v3-0-c9c1342fe3cf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJOPQWoC/32Nyw6CMBBFf4V07Zh2IDxc+R/GBbRTGDWgbSEaw
 r8LGBNd6PIk954zCk+OyYtdNApHA3vu2hniTSR0U7Y1AZuZBUpMZaokGNv7wC1DGS7gNejq5hh
 MgERJnRNmShkj5vvVkeX7qj4cX+z76kQ6LL5l0bAPnXus7UEtu3em+J0ZFEigrCizDGNbVnJ/J
 tfSZdu5WiydAT9MmPwx4WxCm8uksKaQWH2Zpml6AnS0OicdAQAA
X-Change-ID: 20260610-dfustini-atl-sc-cbqri-dt-410c8e2711dd
To: Adrien Ricciardi <aricciardi@baylibre.com>, 
 Alexandre Ghiti <alex@ghiti.fr>, Atish Kumar Patra <atishp@rivosinc.com>, 
 Atish Patra <atish.patra@linux.dev>, Babu Moger <babu.moger@amd.com>, 
 Ben Horgan <ben.horgan@arm.com>, Borislav Petkov <bp@alien8.de>, 
 Chen Pei <cp0613@linux.alibaba.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 Dave Martin <Dave.Martin@arm.com>, Fenghua Yu <fenghua.yu@intel.com>, 
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7503; i=fustini@kernel.org;
 h=from:subject:message-id; bh=llCgYXXJQ5bOYICf9djgNzfbgXeNPCTj/ihuuFFOj10=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWQ59s+bUznrNdu1FvFl2VtbXV7+uLDF07Uj2/LHclPBj
 Dfl7LJmHaUsDGJcDLJiiiybPuRdWOIV+nXB/BfbYOawMoEMYeDiFICJrIxl+F96ItbV4YCwUPAE
 7dd/l7TouIn+fXlwqc3HnItBq4+EaSowMqxi/lauqHRu6onX1389dawJOT0j+oQXz4bNm17VOTS
 eTuUHAA==
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

This series is based on the linux-next tag next-20260623.

[1] https://github.com/riscv/riscv-ssqosid/releases/tag/v1.0
[2] https://github.com/riscv-non-isa/riscv-cbqri/releases/tag/v1.0
[3] https://docs.kernel.org/filesystems/resctrl.html
[4] https://github.com/tt-fustini/qemu/tree/riscv-cbqri-cache
[5] https://lore.kernel.org/linux-riscv/20260601-ssqosid-cbqri-rqsc-v7-0-v6-16-baf00f50028a@kernel.org/
[6] https://lore.kernel.org/all/aab804b9-e8b5-40ad-a85b-af7033391243@intel.com/

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
 arch/riscv/Kconfig                                 |  20 +
 arch/riscv/include/asm/csr.h                       |   5 +
 arch/riscv/include/asm/hwcap.h                     |   1 +
 arch/riscv/include/asm/processor.h                 |   3 +
 arch/riscv/include/asm/qos.h                       |  74 ++
 arch/riscv/include/asm/resctrl.h                   | 147 ++++
 arch/riscv/include/asm/switch_to.h                 |   3 +
 arch/riscv/kernel/Makefile                         |   2 +
 arch/riscv/kernel/cpufeature.c                     |   1 +
 arch/riscv/kernel/qos.c                            |  99 +++
 drivers/resctrl/Kconfig                            |  29 +
 drivers/resctrl/Makefile                           |   5 +
 drivers/resctrl/cbqri_capacity.c                   | 132 ++++
 drivers/resctrl/cbqri_devices.c                    | 562 +++++++++++++++
 drivers/resctrl/cbqri_internal.h                   | 124 ++++
 drivers/resctrl/cbqri_resctrl.c                    | 787 +++++++++++++++++++++
 include/linux/riscv_cbqri.h                        |  47 ++
 20 files changed, 2159 insertions(+)
---
base-commit: 4e5dfb7c84012007c3c7061126491bbc92d71bf1
change-id: 20260610-dfustini-atl-sc-cbqri-dt-410c8e2711dd

Best regards,
--  
Drew Fustini <fustini@kernel.org>

