Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A481119C569
	for <linux-rt-devel@lists.linux.dev>; Wed, 18 Dec 2024 12:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734523250; cv=none; b=pzZKIr0/yMmfmfHbqQYt/7qARzm5JJyKCGI/wUYlmL1UV9zoSWAzfWMsANBAqy3jgoEoQdkKVUFUIYbSKgJhTWvYb/xIBE0ouPTxgYRbSv608+AgvQr7zTnMekub+PNqdVy6H1gsxoh7WJN5reoLqEbCod2YwbRu+vIMap/ykt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734523250; c=relaxed/simple;
	bh=iI8CcKd/V37QUL3zjoDtLya4DdEnUUMzTXkl6cniQYo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RMz7wWFxf6bujq6/Bz+XbS30HQMH6sf4PsFvJPdNEIWoexEXjkkEHKibXdsBpkPyoC/oR/nqZ3yAFJII5HeR12BKRpsLfjZKvIUWGSgHfNHnPV5bbB1pD0P5T5DC9aCnXvDokDz2LFPZIc5nsn26vw4sagA4yIyjLpA4cvuzij4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lSPWAmg3; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lSPWAmg3"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2162c0f6a39so5994395ad.0
        for <linux-rt-devel@lists.linux.dev>; Wed, 18 Dec 2024 04:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734523247; x=1735128047; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WaWpZDhiRTRxudWwp/1DvZDACu+XIJuJhwK7AJhu2/k=;
        b=lSPWAmg3IEHoqB7FmzDMMLHUxS8Qqci0Yes/rDCv9Zs4Je9lrjoNU7STGhzOIlA9iV
         GQdoe7zRVBpI5+Iizv2jLHZcLNov89chbRIZv8TuFn38mV5ccLRB9krUrsQjtO00JMVR
         amhWcxahJlJr4ZckSJH5SfnQNfozw5TXweroxcsiMHBMkzDXPe5n9pSIv3srNtRzEegE
         CLv+tMGxriPQdxxuqvngvlgQ5eHtJDBcoB/vAqJcNBuvAY/IWPXOQ2xk1Qw/l4KC6Odc
         KwykFFe1rOEmtXSHOxm+31gNVojGAPUSE/gye0OmQXwush2w+n+0C/cFD1+BdmlAxxXE
         qivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734523247; x=1735128047;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WaWpZDhiRTRxudWwp/1DvZDACu+XIJuJhwK7AJhu2/k=;
        b=vH/MKVrmH7zY9bonfcpUC3tNzt/HQ1hqQExzAxWr2W9X6zyvjwesgYh3r4LNOnSTdg
         dT/fmu0WhqFqXY/EMfw7GryHBLFy6vF00UBoo3Xdso9dQrwF0s0jpJDWOzBEfTXrTUWs
         0z3tHHtFyk+N11pMrXBeHyw+1WJxEVNTIuafunWnxPj5YpZqJRRUm+99pyyXMFZA5qJ1
         fE6zZwNO7HdveOaTlysfB2W/Kw33tyW33TDeldxBiMsyTPIsDLNHtL4KqFq/cJAHa4ez
         NCGKhIe1bSd08MLdIRuDaiKpA2jePb2BR4oANMaTubGLW3Q0a2TijiJfvZz0ostPcbJH
         Khnw==
X-Forwarded-Encrypted: i=1; AJvYcCWulnPfpNpoYL9XncNpiiGmj/1fzubb0XVnpBg2in7bjkPojgtBOWVvRttY3Zqvnebd2q6Uvt/5gMI9GuaMtg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzpI3pN80lf8mDefymbYeZdJAVHTTdtQkvFJBtTPbb54uj8NFTO
	Hsj9G/J9AzMlCH04dPWDaOWk4eTreJtO7e5J0/u3cm9HncY3ap9V
X-Gm-Gg: ASbGncsAuZcr+W2Ndz+MAFucrkr6cZZPzeFtwNx/ZhD7xfrzae34IQNp4W7x3XdI2ka
	8l31am4TAhWSKGiPZLdx7dxbqprBFl58fAYvCFe7yrf/lS549W57164DC7Xs2jMahNzAiszH91t
	R8g09CGYVWwL1dgTucxFR42GhGYSU51wjMSueNxazfZ8/Qot8Dox5M7vqmwLO5c9xWooLH/nf45
	ZkHiCy98sRtE730xSCIU3VOATQKZf165cy1iAtfAWWxUYbBnNIN/sO0bfAtF7rOOF6hGH6HutvF
	/AMCUYdPpxODY5k4lF8OC76yBYU=
X-Google-Smtp-Source: AGHT+IHlLqLtQQZqcRoHt9aaF3s/cZbLRFv+24vpMgrEkVqTYSG0Rc3QUPea+MFouLzJvfCjGAsm8Q==
X-Received: by 2002:a17:903:2c8:b0:215:8847:4377 with SMTP id d9443c01a7336-218d73b30d6mr37963455ad.15.1734523246681;
        Wed, 18 Dec 2024 04:00:46 -0800 (PST)
Received: from DESKTOP-NBGHJ1C.local.valinux.co.jp (vagw.valinux.co.jp. [210.128.90.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1dcc47bsm75203925ad.63.2024.12.18.04.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 04:00:46 -0800 (PST)
From: Ryo Takakura <ryotkkr98@gmail.com>
To: lgoncalv@redhat.com,
	bhelgaas@google.com,
	jonathan.derrick@linux.dev,
	kw@linux.com,
	lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org,
	nirmal.patel@linux.intel.com,
	robh@kernel.org,
	bigeasy@linutronix.de,
	rostedt@goodmis.org
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Ryo Takakura <ryotkkr98@gmail.com>
Subject: [PATCH v2] PCI: vmd: Fix spinlock usage on config access for RT kernel
Date: Wed, 18 Dec 2024 20:59:51 +0900
Message-Id: <20241218115951.83062-1-ryotkkr98@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PCI config access is locked with pci_lock which serializes
pci_user/bus_write_config*() and pci_user/bus_read_config*().
The subsequently invoked vmd_pci_write() and vmd_pci_read() are also
serialized as they are only invoked by them respectively.

Remove cfg_lock which is taken by vmd_pci_write() and vmd_pci_read()
for their serialization as its already serialized by pci_lock.

This fixes the spinlock_t(cfg_lock) usage within
raw_spinlock_t(pci_lock) on RT kernels where spinlock_t becomes
sleepable.

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

Thanks Luis for feedback!

Changes since v1:
https://lore.kernel.org/lkml/20241215141321.383144-1-ryotkkr98@gmail.com/T/

- Remove cfg_lock instead of converting it to raw spinlock as suggested
  by Sebastian[0].
  
[0] https://lore.kernel.org/linux-rt-users/20230620154434.MosrzRUh@linutronix.de/

---
 drivers/pci/controller/vmd.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 9d9596947..2be898424 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -125,7 +125,6 @@ struct vmd_irq_list {
 struct vmd_dev {
 	struct pci_dev		*dev;
 
-	spinlock_t		cfg_lock;
 	void __iomem		*cfgbar;
 
 	int msix_count;
@@ -385,13 +384,11 @@ static int vmd_pci_read(struct pci_bus *bus, unsigned int devfn, int reg,
 {
 	struct vmd_dev *vmd = vmd_from_bus(bus);
 	void __iomem *addr = vmd_cfg_addr(vmd, bus, devfn, reg, len);
-	unsigned long flags;
 	int ret = 0;
 
 	if (!addr)
 		return -EFAULT;
 
-	spin_lock_irqsave(&vmd->cfg_lock, flags);
 	switch (len) {
 	case 1:
 		*value = readb(addr);
@@ -406,7 +403,6 @@ static int vmd_pci_read(struct pci_bus *bus, unsigned int devfn, int reg,
 		ret = -EINVAL;
 		break;
 	}
-	spin_unlock_irqrestore(&vmd->cfg_lock, flags);
 	return ret;
 }
 
@@ -420,13 +416,11 @@ static int vmd_pci_write(struct pci_bus *bus, unsigned int devfn, int reg,
 {
 	struct vmd_dev *vmd = vmd_from_bus(bus);
 	void __iomem *addr = vmd_cfg_addr(vmd, bus, devfn, reg, len);
-	unsigned long flags;
 	int ret = 0;
 
 	if (!addr)
 		return -EFAULT;
 
-	spin_lock_irqsave(&vmd->cfg_lock, flags);
 	switch (len) {
 	case 1:
 		writeb(value, addr);
@@ -444,7 +438,6 @@ static int vmd_pci_write(struct pci_bus *bus, unsigned int devfn, int reg,
 		ret = -EINVAL;
 		break;
 	}
-	spin_unlock_irqrestore(&vmd->cfg_lock, flags);
 	return ret;
 }
 
@@ -1009,7 +1002,6 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	if (features & VMD_FEAT_OFFSET_FIRST_VECTOR)
 		vmd->first_vec = 1;
 
-	spin_lock_init(&vmd->cfg_lock);
 	pci_set_drvdata(dev, vmd);
 	err = vmd_enable_domain(vmd, features);
 	if (err)
-- 
2.34.1

