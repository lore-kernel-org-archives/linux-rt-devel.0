Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09BF1805A
	for <linux-rt-devel@lists.linux.dev>; Sun, 15 Dec 2024 14:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734272054; cv=none; b=KrM3nnSexFgIaFOQalq4uqtGcf0MBGOvbdocceDrvy3M/tGAJbrAaWxBhtQmORCIouL4hGWpr/fuWFVifNcRawiieFnrT0NLRwtNb/J2jQdpMt/hOdyHvybyTIlUzQsW5Kx4kmtZfnzgQHygRgLSx8bQO45fc3Z4xl78g25WoUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734272054; c=relaxed/simple;
	bh=8/npkK++v8XD3GPktkDpm6YIitVKsIUTk8iGph1pvfQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QkS2Ic2UcLEMcgLNnq70pvBmSx4KdvJlrP3n+vRfSbU9aZEJf19dm5mJ2wrFm2lx06C/cSyuMbdKM8xM+YY5B11a1apNAM5Vh2VPT+jsqsQNkJ0lisC5ZvjmpoJeRNlOzJPblxfBTcYcfIJKAmkOK3vx+WE+OywrjkofH2zsft0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W7oR7pKH; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W7oR7pKH"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2ee9a780de4so2092743a91.3
        for <linux-rt-devel@lists.linux.dev>; Sun, 15 Dec 2024 06:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734272052; x=1734876852; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9LsvqKWOporQY61apVbKBTly+yYgOeAnVkx2Qbcnreg=;
        b=W7oR7pKHUAhQzUabhwgyEvAVia1YZJzeu4ld0QtEGDCLQ3wk75aCyfQDIecpc4Rt3J
         f59GGONDC3VTj+Mg0l9OhjAugCwkAt/atYV9yuq01+D0JBZathKMh1wALYrVHyGmTbhQ
         5VJ2OCFhtMDMw5BhfM2KF6iizmqrfixL+pN9cC7C9KWIuiJaJxZrP76dtuPhTkjMrT1b
         Q0oDFFZ6R6QuQd0aqJwp8iD+wqDzFbQdknaAtbX7+2naPJLA6Jjo9N5+fU67ULUf/2j7
         KGKwG/RiFI7afPF2qdmVldQROUULPMEHUQdVFDk4kogtH0ULkO2JlGzVCBJVuK4jBRQ3
         NbxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734272052; x=1734876852;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9LsvqKWOporQY61apVbKBTly+yYgOeAnVkx2Qbcnreg=;
        b=iqKM6xyqxKgwQb78UsmZFpOeMOYSZ+y+TVcVoUGLBsi55ddb9EaLNZPUnK11/p/hNQ
         1xjQlvBxcM1h3s3MQUE/cu5IB3Tth5H1ZPrvij5fy29OP/L9m+Tf8WUc/BtmnLikVDUM
         ZOdEdXJx6jUmV0UvbZ9rlkEiZkAbTRLBTZ4ndoLZS0Mx+uht/6N/8DifL7XL/Nh22iLo
         S6GR2DLx3vuA1yDYFiJvSw8sogBGESi+aMwsxkvxDzTcamb0a2z2JV+KifTOGoDzSxgz
         k3L5z1nJrOpeyaqF/96/dDFJPvt9AYgF0+SvgBsqco2RPmERPJX3G/7YgbUVjYNeBkLr
         0tuA==
X-Forwarded-Encrypted: i=1; AJvYcCVQIV5FidlRyyTe3rmpqn5VI7ZoeGaxTqfeD+ofnNltZIHAKAjbxJHG6d1MWn/sprA7LVIyezTNoLfwlrNVzQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwoiNgf6P9Y+vkQpNjZ2COdUTL774UZY40Di14PHGiwweymwTsx
	B93dGzhNgPxSx5HuaG1Q0oKORlRfNx+bbLu1EebocnVle/q/JKF5
X-Gm-Gg: ASbGnctD0TmAObWvUgUyPE7dLlXJAEBqnw0lKZj7Wl8UxdvREbr+S7f9lwDq5njRDFW
	68N76/CFXPDEWWokV8uL1qj8OHFgWSSMu/tdL3t2lVDibXw+WZyj3vxSeWGwGU4zA+2hxD5aUFV
	f5l98RKrMoRDN6GGkHmOfHhAho27ZujhhKmcnDXpv7elwiyIf6EnKjEAMtBEoP/x1mG3y0AnMyk
	Ff8krjSIM0DPnT/bhPZ+wYqnnIrBGS0kgk2EzwOpO8U5v9ZKAoQt/JEzAArLXuA80y2QjD0TxBg
	kZBi2ztFUYWXLIo5opvcCsX0sN5QAzTfxg3Y0rXLYDSlFe8M
X-Google-Smtp-Source: AGHT+IF0q+IRcOZ9CtJYH09ox5ZR3xLRy7+T7K2ySdfdihcsK4iWEgQ3Fy0GUjpfJMuf4KaMqao0tw==
X-Received: by 2002:a17:90b:5345:b0:2ee:fdf3:38dd with SMTP id 98e67ed59e1d1-2f28ffa7ea5mr11685579a91.23.1734272052017;
        Sun, 15 Dec 2024 06:14:12 -0800 (PST)
Received: from localhost.localdomain (p10213112-ipngn20001marunouchi.tokyo.ocn.ne.jp. [153.220.101.112])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142f9e193sm6314823a91.32.2024.12.15.06.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 06:14:11 -0800 (PST)
From: Ryo Takakura <ryotkkr98@gmail.com>
To: nirmal.patel@linux.intel.com,
	jonathan.derrick@linux.dev,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Ryo Takakura <ryotkkr98@gmail.com>
Subject: [PATCH] PCI: vmd: Fix spinlock usage on config access for RT kernel
Date: Sun, 15 Dec 2024 23:13:21 +0900
Message-Id: <20241215141321.383144-1-ryotkkr98@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PCI config access is locked with pci_lock which is raw_spinlock.
Convert cfg_lock to raw_spinlock so that the lock usage is consistent
for RT kernel.

Reported as following:
[   18.756807] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
[   18.756810] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 1617, name: nodedev-init
[   18.756810] preempt_count: 1, expected: 0
[   18.756811] RCU nest depth: 0, expected: 0
[   18.756811] INFO: lockdep is turned off.
[   18.756812] irq event stamp: 0
[   18.756812] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[   18.756815] hardirqs last disabled at (0): [<ffffffff864f1fe2>] copy_process+0xa62/0x2d90
[   18.756819] softirqs last  enabled at (0): [<ffffffff864f1fe2>] copy_process+0xa62/0x2d90
[   18.756820] softirqs last disabled at (0): [<0000000000000000>] 0x0
[   18.756822] CPU: 3 UID: 0 PID: 1617 Comm: nodedev-init Tainted: G        W          6.12.1 #11
[   18.756823] Tainted: [W]=WARN
[   18.756824] Hardware name: Dell Inc. Vostro 3710/0K1D6X, BIOS 1.14.0 06/09/2023
[   18.756825] Call Trace:
[   18.756826]  <TASK>
[   18.756827]  dump_stack_lvl+0x9b/0xf0
[   18.756830]  dump_stack+0x10/0x20
[   18.756831]  __might_resched+0x158/0x230
[   18.756833]  rt_spin_lock+0x4e/0x130
[   18.756837]  ? vmd_pci_read+0x8d/0x100 [vmd]
[   18.756839]  vmd_pci_read+0x8d/0x100 [vmd]
[   18.756840]  pci_user_read_config_byte+0x6f/0xe0
[   18.756843]  pci_read_config+0xfe/0x290
[   18.756845]  sysfs_kf_bin_read+0x68/0x90
[   18.756847]  kernfs_fop_read_iter+0xd7/0x200
[   18.756850]  vfs_read+0x26d/0x360
[   18.756853]  ksys_read+0x70/0xf0
[   18.756855]  __x64_sys_read+0x1a/0x20
[   18.756857]  x64_sys_call+0x1715/0x20d0
[   18.756859]  do_syscall_64+0x8f/0x170
[   18.756861]  ? syscall_exit_to_user_mode+0xcd/0x2c0
[   18.756863]  ? do_syscall_64+0x9b/0x170
[   18.756865]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

Signed-off-by: Ryo Takakura <ryotkkr98@gmail.com>
---
 drivers/pci/controller/vmd.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 9d9596947..94ceec50a 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -125,7 +125,7 @@ struct vmd_irq_list {
 struct vmd_dev {
 	struct pci_dev		*dev;
 
-	spinlock_t		cfg_lock;
+	raw_spinlock_t		cfg_lock;
 	void __iomem		*cfgbar;
 
 	int msix_count;
@@ -391,7 +391,7 @@ static int vmd_pci_read(struct pci_bus *bus, unsigned int devfn, int reg,
 	if (!addr)
 		return -EFAULT;
 
-	spin_lock_irqsave(&vmd->cfg_lock, flags);
+	raw_spin_lock_irqsave(&vmd->cfg_lock, flags);
 	switch (len) {
 	case 1:
 		*value = readb(addr);
@@ -406,7 +406,7 @@ static int vmd_pci_read(struct pci_bus *bus, unsigned int devfn, int reg,
 		ret = -EINVAL;
 		break;
 	}
-	spin_unlock_irqrestore(&vmd->cfg_lock, flags);
+	raw_spin_unlock_irqrestore(&vmd->cfg_lock, flags);
 	return ret;
 }
 
@@ -426,7 +426,7 @@ static int vmd_pci_write(struct pci_bus *bus, unsigned int devfn, int reg,
 	if (!addr)
 		return -EFAULT;
 
-	spin_lock_irqsave(&vmd->cfg_lock, flags);
+	raw_spin_lock_irqsave(&vmd->cfg_lock, flags);
 	switch (len) {
 	case 1:
 		writeb(value, addr);
@@ -444,7 +444,7 @@ static int vmd_pci_write(struct pci_bus *bus, unsigned int devfn, int reg,
 		ret = -EINVAL;
 		break;
 	}
-	spin_unlock_irqrestore(&vmd->cfg_lock, flags);
+	raw_spin_unlock_irqrestore(&vmd->cfg_lock, flags);
 	return ret;
 }
 
@@ -1009,7 +1009,7 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	if (features & VMD_FEAT_OFFSET_FIRST_VECTOR)
 		vmd->first_vec = 1;
 
-	spin_lock_init(&vmd->cfg_lock);
+	raw_spin_lock_init(&vmd->cfg_lock);
 	pci_set_drvdata(dev, vmd);
 	err = vmd_enable_domain(vmd, features);
 	if (err)
-- 
2.34.1

