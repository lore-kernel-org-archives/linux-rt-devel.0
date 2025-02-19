Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C7B215040
	for <linux-rt-devel@lists.linux.dev>; Wed, 19 Feb 2025 18:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739988995; cv=none; b=o2dHEeDl4Q5Ie8oC2zqCaWQVLYEUACDl2jOwfIjquccfG8u7rVVYKOvW/8P8n0aX5m1Ktjfk+I8111ZiDpRHtULqJcH11z/+/Lm3JwVC80EpwSqLLBw1wmFEWWAVeCB4Im37AIK7AgSV5A6wBnkxGBZuGeQ9celKDjlot4AlteU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739988995; c=relaxed/simple;
	bh=bH0LnxAkANrFnbgQGbgWcMkIQPF2gj+UHBqxzcqtXjU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z251XjZnreTiesS0/COpwhG5/S6giSGjXGo2Txzo77nX5/xytlSe0PW1nBqOrmWlcu2q0fqF5Owb7uBBQL19xm9vC2c3YkLxSnOc2cSxbK6YTyBPXmlgDUFOQX8iMiI6DqftHPpHmStHJGUOxzLzNdZDvV1OwrXOgZIIOb88hvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oQCup6NM; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oQCup6NM"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6e660740061so150006d6.3
        for <linux-rt-devel@lists.linux.dev>; Wed, 19 Feb 2025 10:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739988991; x=1740593791; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xlbf30x0uNFungZc8BjzdSdt4uJVOLJQoZrvNr982Z4=;
        b=oQCup6NMD6jvvppAsTbL7jn+hiS3JrWrfIcvXf2/oqnrzUhI3GUpsJzSWKLeDshb8O
         RVc1Xce9FcyFr1wz2TZK4jepOAstgMBmm8YGpG8Dew5H50ht7fJRvc6yuNepsbP9oSVO
         nNLGJZ6FG79RCJjEIWS48UOSMaNCXf7hOcC2XbTZX/FP+OBb4bFmJp7xvslchFH98Hz/
         D9y6knYhhycPF/bz9KDMskJTbV2isjr/O/xf5LO7LA6k+rbzZPI8NmHLDKmabGe+Ssg7
         a5wqdS4VB0UtSRa/tUZrMappAadNhQ+/ag2RE6bdpjbNJNv4iEJpxhOpWORCQ2bINP2W
         5SHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739988991; x=1740593791;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xlbf30x0uNFungZc8BjzdSdt4uJVOLJQoZrvNr982Z4=;
        b=Sn1ZV25KWTD2FPSJlWC2jYoJt9oEbXfcTACBbBtvXNh1dj8N46TP6If1U0OGoHchRQ
         Yqqh7OOkHRALAkJKtc/R/3RUSZY95DmDkPQwzbbf/J9ZL7d1Pl1nd9zDpQGFGLMT4AVQ
         +opn28UwwU0hkmSoNO4C5QTSz5aLAX7EyM3TgKCzJ83AOBy6akoec3ZisS1aryuZ1iVt
         8RDYTCyEyNx7+r9QqTuOEkbVioFd/vhqSyFrX5vJqH9DRhOVmowgib/eAcZJPhHqFrRC
         +5irQfcwPkv7Qwi8vaZaCcjvxWUvOgfX3K+vn0niUcFSasW44OpqMS7n8iTRP2+9dPlR
         RJ3A==
X-Gm-Message-State: AOJu0Yw0jGoialyLJaFBHXYnp7UqsY+wlAx3SrjWlqrAk/8wNXB0dRYP
	I++lwfEHNFomTv/D9sRKt3s6/Xj0soIXX+NLjoO1b6/x7WYl5xy8ZJ/Vs9gyj4p+CESSfWVvZf/
	h
X-Gm-Gg: ASbGnctNc4znrB1KNZKEWPdrzGeLF96Vw1VXHZb1B4QsE97szxalnq6vZLrnBtq6zES
	TVneyCHwqN0VkDQNRUm4xUqnN54R68k/8FSVgIjhAI0/h4FWRRXMOkptYkM7x79ANWD7z3MSYNT
	TQG6rok+40l49lER/RXPP+aFHv4X0mm5z4ot1/9a434tkhmAUaP0+GSm865u5U8rSCB3pDoaafA
	bGZliOGD33XfGiKrvrDCuQ0IEnEg8YU4tOPLdtLvBTh+vsiP6Q5TktuDAYC/1yYGjRSJbmAV4E2
	NFYPpiQCvWuz5d8=
X-Google-Smtp-Source: AGHT+IGRbWWvXf5h1lYoK4mfqaPbGMmhAWcsiQxS9BI2ulaH26wMHaL1bNQlGCgZmcBATXiOR7+yzQ==
X-Received: by 2002:a05:6214:2586:b0:6e6:6c10:76fb with SMTP id 6a1803df08f44-6e69750c134mr70728246d6.25.1739988991095;
        Wed, 19 Feb 2025 10:16:31 -0800 (PST)
Received: from maple.. ([174.89.15.101])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d9f38absm77357466d6.88.2025.02.19.10.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 10:16:26 -0800 (PST)
From: Ralph Siemsen <ralph.siemsen@linaro.org>
To: linux-rt-devel@lists.linux.dev,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pawel Laszczak <pawell@cadence.com>,
	Frank Li <Frank.Li@nxp.com>,
	Ferry Toth <ftoth@exalondelft.nl>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ralph Siemsen <ralph.siemsen@linaro.org>
Subject: [RFC PATCH] usb: gadget: u_ether: prevent deadlock under RT
Date: Wed, 19 Feb 2025 13:15:52 -0500
Message-ID: <20250219181556.1020029-1-ralph.siemsen@linaro.org>
X-Mailer: git-send-email 2.45.2.121.gc2b3f2b3cd
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A deadlock can be readily triggered when using NCM gadget with the
Cadence cdns3 USB driver, under heavy traffic from "iperf3 --bidir".
It has been observed under 6.1, 6.6 and 6.12 kernel versions, but
only on PREEMPT_RT. Once deadlocked, even magicsysrq has no effect.
However, there is periodic output from the rcu stall detector:

[   71.105941] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[   71.105966] rcu:     Tasks blocked on level-0 rcu_node (CPUs 0-1): P125/4:b..l
[   71.105992] rcu:     (detected by 1, t=5252 jiffies, g=-515, q=7 ncpus=2)
[   71.106003] task:irq/507-s-f4000 state:D stack:0     pid:125   tgid:125   ppid:2      flags:0x00000008
[   71.106018] Call trace:
[   71.106022]  __switch_to+0xf4/0x158
[   71.106046]  __schedule+0x2b4/0x920
[   71.106055]  schedule_rtlock+0x24/0x50
[   71.106064]  rtlock_slowlock_locked+0x348/0xcb8
[   71.106077]  rt_spin_lock+0x88/0xb8
[   71.106086]  eth_start_xmit+0x30/0x1490 [u_ether]        /*****/
[   71.106112]  ncm_tx_timeout+0x2c/0x50 [usb_f_ncm]
[   71.106131]  __hrtimer_run_queues+0x180/0x378
[   71.106143]  hrtimer_run_softirq+0x90/0x100
[   71.106151]  handle_softirqs.isra.0+0x14c/0x360
[   71.106165]  __local_bh_enable_ip+0x104/0x118
[   71.106177]  __netdev_alloc_skb+0x1e0/0x210
[   71.106192]  ncm_unwrap_ntb+0x1ec/0x528 [usb_f_ncm]
[   71.106206]  rx_complete+0x120/0x288 [u_ether]           /*****/
[   71.106221]  usb_gadget_giveback_request+0x34/0xf8
[   71.106236]  cdns3_gadget_giveback+0xe4/0x2d0 [cdns3]
[   71.106286]  cdns3_transfer_completed+0x3b0/0x630 [cdns3]
[   71.106320]  cdns3_device_thread_irq_handler+0x8b8/0xd18 [cdns3]
[   71.106353]  irq_thread_fn+0x34/0xb8
[   71.106364]  irq_thread+0x180/0x2f0
[   71.106374]  kthread+0x104/0x118
[   71.106384]  ret_from_fork+0x10/0x20

The deadlock occurs because eth_start_xmit() and rx_complete() both
acquire the same spinlock in the same instance of struct eth_dev.
The nested call occurs because rx_complete() calls __netdev_alloc_skb()
which performs a brief local_bh_disable/enable() sequence.

Prevent the deadlock by disabling softirq in rx_complete(), with the
same scope as the spinlock. With this fix, no deadlocks are observed
over many hours of continuous testing at USB 2.0 speed (480 Mbit/s).

Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
---
Discussion items:

0) This is somewhat similar to the recent discussion
https://lore.kernel.org/linux-rt-devel/20250212123302.0f620f23@gandalf.local.home/
and my solution is to "sprinkle local_bh_disable() around",
which is clearly not optimal. Hence the RFC on this patch.

1) There are several more places using the same spinlock, for example
the gether_suspend() and gether_resume() functions. I'm not using power
management, but I wonder if there might be more deadlocks lurking?

2) By keeping softirq disabled for a longer duration, this patch could
potentially increase the RT latency. I tried to quantify this using
cyclictest, but I cannot get a baseline for comparison, since it
deadlocks almost immediately when the USB is active. Other suggestions?

3) The fix is in generic u_ether.c code, to match the scope of the
spinlock. Alternatively, it could be done in cdns3 specific code,
such as in cdns3_device_thread_irq_handler(). I'm not sure if the
same problem exists in other USB drivers?
---
 drivers/usb/gadget/function/u_ether.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/gadget/function/u_ether.c b/drivers/usb/gadget/function/u_ether.c
index 09e2838917e2..dc511c01b741 100644
--- a/drivers/usb/gadget/function/u_ether.c
+++ b/drivers/usb/gadget/function/u_ether.c
@@ -233,6 +233,7 @@ static void rx_complete(struct usb_ep *ep, struct usb_request *req)
 		if (dev->unwrap) {
 			unsigned long	flags;
 
+			local_bh_disable();
 			spin_lock_irqsave(&dev->lock, flags);
 			if (dev->port_usb) {
 				status = dev->unwrap(dev->port_usb,
@@ -243,6 +244,7 @@ static void rx_complete(struct usb_ep *ep, struct usb_request *req)
 				status = -ENOTCONN;
 			}
 			spin_unlock_irqrestore(&dev->lock, flags);
+			local_bh_enable();
 		} else {
 			skb_queue_tail(&dev->rx_frames, skb);
 		}
-- 
2.45.2.121.gc2b3f2b3cd

