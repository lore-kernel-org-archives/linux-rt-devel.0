Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDF320E034
	for <linux-rt-devel@lists.linux.dev>; Tue, 18 Mar 2025 15:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742310588; cv=none; b=D2Ex3qKShxCKFGFVs3Qnkuy1QsrXu5myzguCKqhinEG5ufFWdn0svm2vfbbP+ACJ1P9buxcu8674jb28DaMUZ4r3d8YLHe5xzjprt/SB6wrGZLiUiUP2YBDj494LYZRUQO9dYzBKCfIYRot0yydOiDpOFjsOkoO3w5v9qMdSrBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742310588; c=relaxed/simple;
	bh=up3vEH/2NyMI9+tvTMWFdSxU1SLIqBztBb2NGlnwDRE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=EXW/lW6LVyhult1cKF5kYtohfkKmeMqUGoh4BfLbrQx9BJ02m1/x7f7cPoDN54bUdzPYMU17a5A1suwXi6JY7V5nD/kMNQZAXqqiVNs/F/dHF9qRx3WdAAZKWAIaPLOx2ZY9/8ssZcQgfYr4fj+bFOuJ8afPqJP25zHpNAIDgfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UWkr/oiA; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UWkr/oiA"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c5675dec99so620397185a.0
        for <linux-rt-devel@lists.linux.dev>; Tue, 18 Mar 2025 08:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742310585; x=1742915385; darn=lists.linux.dev;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y8KvHOzHLjO6KpO+17xD+gf6z/bYQ+D5l2z1JLTz/U8=;
        b=UWkr/oiAI+bYm5SVwzgpOnSiapeEZIstTu88eFDWAOWASDzX+IwcyJCDboTcvs/qee
         Put8y3QVNpBwHpIci6Rzg+c01GG4vDQ4P41L8nJr6wO8Sxn8PIA59MJwesbBACLF1vGM
         ICQkb0MmJ8FX3/E1hW2OauZlKftCN6arkFF/XPeOYGgpeYLoVjH+FT3ePpoPRtLaAmNc
         dFXZx6u/unV56FwncdLXOrQB/gYvvPK0OIKJmKr5vXBOGBdUuFU1i8sp+Xw80fII4Wh3
         AjhcacxWPVpQKdm0Z2dTtRDczUvMUUF3N3D5K0h3gjCXMM7nrUYo/MLi5NP4obz3q1O6
         wa9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742310585; x=1742915385;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y8KvHOzHLjO6KpO+17xD+gf6z/bYQ+D5l2z1JLTz/U8=;
        b=hZ4gmUjvrLypQY4MrapBuSnWeSW6dqkFR0r5WVnGPAzOHtKpht4CXRoYvHOzEpfEWn
         M/sxEKNLPsBythO0jxDGNbU29a/0uYOf1Bed2TtdIE4z3BJckzctP89B4InAihtAPdIh
         PieSVyahF9IU8L2nd0ENGVnNDr335v7SHK4z2s62h0RWGVppaEXoii2rofW7tc1WNV+v
         VaC1waV+cui+MVDFaV4CEb12rvIZSOLcZQpXKC6e2mUFNDIgSCC4MmBiSuKsCN+W+/uj
         fAPT0Xjeb5bGGWHwUp9mJOJsvMnMHDhtmM9zfwClsWdv29FEQcwCV4PomhH6Enba+G07
         dmPA==
X-Forwarded-Encrypted: i=1; AJvYcCVfsf2hfDPGbKmSXzf9+hBtkdu4/B/uki1OzBU99XnEBNGYzTuJ1W2xYkF2Q7Oc4Gd9QXSauh239LKIlC1eDA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx/98DVmK0M3rH8asFYEWAVhKrKx2evcOmpnWEWPalwMuHO+Pz8
	YHTmo62shiI+Ow3jjIx+xg+HZNvuRQkLO+MjglA6ahXVzyKzwD4B7CYae78jC4I=
X-Gm-Gg: ASbGnctenuAKHGrJym+Dcyc9Y9Jl7N0w8BzN5MNXh2oNL/mVWmBs/7bMvaYrWSzv1Q9
	uYtiiZwhKJzTWlgwv9S4JDPSOXrm4pm8ntPy7sErLjaRjuybmcOXy3WRCV7mEMBkLqOjJbUNIYr
	Ks3uP1JptBFgFJUWHrIhEwkY0tQL6YGx2LmQzeQt9nldfT4oPra6BquYqm/F7DhvdfqiC3EBS/+
	6b4rPDpqg8loehEx2VRwrDTa6yd0r1z7nEAwSI+kt32RBWD2UD9yLH0ND4AwInJH0PnW4aHkt+u
	R5RaX4+xUlJGecxWCuwHjTzmtPpN2+sVGWU2KTSLLaTreIMjJK2hDddNkxAjGLLfBh6+a60=
X-Google-Smtp-Source: AGHT+IEvlO3xHMq98UWUgmnAVEnhA/g6K+SfAxe199aM//I35slXn4vPlXVoilOfP/0Qmw5F3dgFjA==
X-Received: by 2002:a05:620a:4010:b0:7c5:5768:40b9 with SMTP id af79cd13be357-7c57c8fc43amr2395060285a.43.1742310585406;
        Tue, 18 Mar 2025 08:09:45 -0700 (PDT)
Received: from maple.netwinder.org ([174.89.15.101])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573d701besm735044185a.68.2025.03.18.08.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 08:09:45 -0700 (PDT)
From: Ralph Siemsen <ralph.siemsen@linaro.org>
Date: Tue, 18 Mar 2025 11:09:32 -0400
Subject: [PATCH v2] usb: cdns3: Fix deadlock when using NCM gadget
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-rfs-cdns3-deadlock-v2-1-bfd9cfcee732@linaro.org>
X-B4-Tracking: v=1; b=H4sIAKuM2WcC/z3MQQrCMBCF4auUrJ2STEi1rryHuAjJpA22SZkRE
 UrvbnDh8oP3/l0JcSZR125XTO8suZYGPHUqzL5MBDk2K9TotDUInARCLGIhko9LDU8YxnNMLvh
 oA6l23JhS/vyi90dz4rrCa+a2/6fQjOZinBt6o1FrHMEA+2Wbe8m0CpXbkovn2lee1HF8AYgWL
 Y2oAAAA
X-Change-ID: 20250312-rfs-cdns3-deadlock-697df5cad3ce
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Peter Chen <peter.chen@kernel.org>, Pawel Laszczak <pawell@cadence.com>, 
 Roger Quadros <rogerq@kernel.org>, Aswath Govindraju <a-govindraju@ti.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Felipe Balbi <felipe.balbi@linux.intel.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev, Thomas Gleixner <tglx@linutronix.de>, 
 Steven Rostedt <rostedt@goodmis.org>, stable@vger.kernel.org, 
 Ralph Siemsen <ralph.siemsen@linaro.org>
X-Mailer: b4 0.15-dev-c25d1

The cdns3 driver has the same NCM deadlock as fixed in cdnsp by commit
58f2fcb3a845 ("usb: cdnsp: Fix deadlock issue during using NCM gadget").

Under PREEMPT_RT the deadlock can be readily triggered by heavy network
traffic, for example using "iperf --bidir" over NCM ethernet link.

The deadlock occurs because the threaded interrupt handler gets
preempted by a softirq, but both are protected by the same spinlock.
Prevent deadlock by disabling softirq during threaded irq handler.

cc: stable@vger.kernel.org
Fixes: 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
---
v2 changes:
- move the fix up the call stack, as per discussion at
https://lore.kernel.org/linux-rt-devel/20250226082931.-XRIDa6D@linutronix.de/
---
 drivers/usb/cdns3/cdns3-gadget.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
index fd1beb10bba72..19101ff1cf1bd 100644
--- a/drivers/usb/cdns3/cdns3-gadget.c
+++ b/drivers/usb/cdns3/cdns3-gadget.c
@@ -1963,6 +1963,7 @@ static irqreturn_t cdns3_device_thread_irq_handler(int irq, void *data)
 	unsigned int bit;
 	unsigned long reg;
 
+	local_bh_disable();
 	spin_lock_irqsave(&priv_dev->lock, flags);
 
 	reg = readl(&priv_dev->regs->usb_ists);
@@ -2004,6 +2005,7 @@ static irqreturn_t cdns3_device_thread_irq_handler(int irq, void *data)
 irqend:
 	writel(~0, &priv_dev->regs->ep_ien);
 	spin_unlock_irqrestore(&priv_dev->lock, flags);
+	local_bh_enable();
 
 	return ret;
 }

---
base-commit: 4701f33a10702d5fc577c32434eb62adde0a1ae1
change-id: 20250312-rfs-cdns3-deadlock-697df5cad3ce

Best regards,
-- 
Ralph Siemsen <ralph.siemsen@linaro.org>

