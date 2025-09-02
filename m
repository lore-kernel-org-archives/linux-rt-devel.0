Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CAC27990A
	for <linux-rt-devel@lists.linux.dev>; Tue,  2 Sep 2025 22:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756853124; cv=none; b=QWc2UkQK9MRRNkdYmpoVTtU9uKczDAW/y42sWkSOsBXpIv1I65K8kHxk4DwmkH92evfYytzKtkFq7Ov9VyR2VkBXH0ygdK5Zj1kXfWk+zHL0GRmkVilf5VwE6Diq2jqyEfGcRXHvGLpG5NBy+kM8sJdBCmXxvyP+3+F3q5WKR8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756853124; c=relaxed/simple;
	bh=za1IhyeT1KHUL8P6O84MBxuBubv4gycG9hGlmDgXhbM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=UYvDBfxxonsY2NN8MF/MXl/z4Tg1+Yqds9z3jnsE938Tqt5GdD22X5ajWxlAkQOXW/Fk+4o3wIsIeFVjZL6yild/X6elbcfc9qzBravHDcMnX6HRIAVir9wRikm6lD9e4GU4v4qazMLOSfK9sUi1xPDzGKBnF20hb7qkN/Iy/pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S9oERQyS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S9oERQyS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756853121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RJyVMg+m0HnoyVkyf5gUwY/kUFpbW+dsoDfxJhmLAUE=;
	b=S9oERQySK8DiggByPPA7gDXN39N85kcQd9T6bv3Se61q4kO8jORUtnmghlDmAHhHU7npz8
	42mHVaXu/VATrO2taMq7n/Gt0SOuzxjRbjudE8FSpi+7RHVGoAeojTXMef904DkcJLgtSu
	mG/coo1zG/SOUw/pfbnW+hNW72tKJxY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-lvtChdIvNuuijgp-x3zGvg-1; Tue, 02 Sep 2025 18:45:20 -0400
X-MC-Unique: lvtChdIvNuuijgp-x3zGvg-1
X-Mimecast-MFC-AGG-ID: lvtChdIvNuuijgp-x3zGvg_1756853120
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70faf8b375cso70259436d6.0
        for <linux-rt-devel@lists.linux.dev>; Tue, 02 Sep 2025 15:45:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756853120; x=1757457920;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RJyVMg+m0HnoyVkyf5gUwY/kUFpbW+dsoDfxJhmLAUE=;
        b=pgMEut0PaV/F0DTghM3CijeAPaneP8qeNISloNryuvQmL9ALbevoAk+qBhGbf0wEeV
         Q0suWOeWVWPUgJrW1z4H5WHi7Kpc6d8MJxK4xzF3v4Ymju1NdBlPO9De0sozV60cD8fa
         0oOS8MyMPWfwWPTdDZk0ZRvUlKXwj7I1Bn2XK2S42wUBkmGYYSGsfHwBMCkQ811iuXu0
         85WW6TEaq4QlP8D94MyjA9r2RIvGoCW6/A7j/0uGE7ppImg3wA0MtGWdI56gp9V9lnG6
         /yV+5PZuaVZJbmwXQuDQx10Gsi2ju8DF5mmJAlsC5SPLhMwMlGg7SxytDeubTp3txVX2
         hgEw==
X-Forwarded-Encrypted: i=1; AJvYcCURpTG1Mj209fDSvA+/SoPUc+8tETT0PlGDkayZPZTpS9KJ+yHPxkDv+rn8mXeqAOtY0z7wuw1LieW+u0RqaA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzqhMQ22HiIo5uWCTb1jkZezl6ehzCKUJkK2FnlGApJceWP1yUc
	ml6BbMEEAdK96Y5s8Mxrcqc5navi6Ip+++rIDfXmr538rzz+6wdAIGPERKtFjZrk5jJyMKWg3qc
	tf8I2rZskr3kUNIgtLcgDwUgZhB5bvvduFCrIu/09h9zKZURJA97yX37XkpLLQejmQ0S4
X-Gm-Gg: ASbGncuuDue0FjaEMerUuim2+Uas1AVVaOoc53CbQe8SsF0beOtiDL6pVj7UKW5JcGH
	VtW5DdrNT2nsCd9fi9/2OQTEvf/7NdDqm6HrLP6MtNNZ2m90rNWOEZ6fgeL12iehfH1OmVQ4V6y
	7a+T6JkGdWWm4vgSH1ZC9xFST0BKvllE/2eHd6ajMTpLowaxJpuTdofr3SXulbDHXp1255D0r22
	vpX7hmQqMV+2iLv8kkK7Z/PXaSG7reOY6uohQ88+d8Lr5eFRHYWC9a/bfMjke1fLaDH9Lx5SmBJ
	3m1uDronklcgTguiMD5Sqc5e6BtCtaoL1IqvOSRN5j16GKbZi+yhFX2BalFPVU3bdR90
X-Received: by 2002:a05:6214:62d:b0:70d:6df3:9a7c with SMTP id 6a1803df08f44-70fac91f549mr163001536d6.60.1756853120051;
        Tue, 02 Sep 2025 15:45:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZJ7Rb63m7d1x/fV7yb6DC5dPEHvsph5C1Gwo41SOjU8ruCfu4BA/m7dr3bqjoAfkOYnnrlA==
X-Received: by 2002:a05:6214:62d:b0:70d:6df3:9a7c with SMTP id 6a1803df08f44-70fac91f549mr163001246d6.60.1756853119647;
        Tue, 02 Sep 2025 15:45:19 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([50.145.183.242])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720ac16e430sm19861206d6.5.2025.09.02.15.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 15:45:19 -0700 (PDT)
From: Crystal Wood <crwood@redhat.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Attila Fazekas <afazekas@redhat.com>,
	linux-pci@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH] PCI/AER: Use IRQF_NO_THREAD on aer_irq
Date: Tue,  2 Sep 2025 17:44:41 -0500
Message-ID: <20250902224441.368483-1-crwood@redhat.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pFFBt1_9vzShET6MhBCGzNc1D9ZizcKQokCgnem4u-U_1756853120
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

On PREEMPT_RT, currently both aer_irq and aer_isr run in separate threads,
at the same FIFO priority.  This can lead to the aer_isr thread starving
the aer_irq thread, particularly if multi_error_valid causes a scan of
all devices, and multiple errors are raised during the scan.

On !PREEMPT_RT, or if aer_irq runs at a higher priority than aer_isr, these
errors can be queued as single-error events as they happen.  But if aer_irq
can't run until aer_isr finishes, by that time the multi event bit will be
set again, causing a new scan and an infinite loop.

Signed-off-by: Crystal Wood <crwood@redhat.com>
---
I'm seeing this on a particular ARM server when using /sys/bus/pci/rescan,
though the internal reporter sometimes saw it happen on boot as well.
On !PREEMPT_RT, or with this patch, a finite number of errors are emitted
and the scan completes.
---
 drivers/pci/pcie/aer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 15ed541d2fbe..6945a112a5cd 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1671,7 +1671,8 @@ static int aer_probe(struct pcie_device *dev)
 	set_service_data(dev, rpc);
 
 	status = devm_request_threaded_irq(device, dev->irq, aer_irq, aer_isr,
-					   IRQF_SHARED, "aerdrv", dev);
+					   IRQF_NO_THREAD | IRQF_SHARED,
+					   "aerdrv", dev);
 	if (status) {
 		pci_err(port, "request AER IRQ %d failed\n", dev->irq);
 		return status;
-- 
2.47.1

