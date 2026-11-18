Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794989809;
	b=TKKxX4exygK+uCvDjE85RM4ZvUeSCLxRisfkKd0bebX0/KUaQH/rpt2QEeKOV7TyMhgH
	 xn5+dhuNz6RyC3+IxfPMdbYgsvhk9ISH3W2p1wvlMf0vTJNnLKuMh41T3kkL0XvmFv8OA
	 JpXqekiEsHNeGSu2JS66m+GKGZw6Y1x0OXAYozkCXinlB7B1L9TR+gHM61IbhMTLSxuQA
	 u+vvk4vdF+1YovQhHvqPjWNV6rNa8uohnLO+OK7xiQSONIwK8akn5iNh6IuqP91FedAGw
	 ptQjrKfL6LNm5pM1AS0g+T6pY74Ov3OozPPn0EETNGghx8s/yLdw/dn0TLhPrCWEuLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794989809;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=n/X/ib+QXW0aM8E5khBCUAfePu160JSALCSJ/A5VZrw=;
	b=g5pZW+LPER3/+ptRwl6oLpnp/eKpjRBXNM8rXx7ij+vW5fhFn8O2Ic42ZK1yd9sGpAJZ
	 GNImQSz8t8XjJrax6UuZ1wm0tgWcXZupzQK7a/sxL+39B0gfIRVw2r3lulJbkHphNc+gK
	 v58Kll7Gi8t0nD6T1e4Zz9864JQqanpIsMEVLpqrEzEYPve/JUAu1ABsKzrDhOu9IDIB6
	 gV4TbZ72Fok5/XRvQB0LwOjc4khvT1BKPBXuvb48+CMIsgYkAvhL5iYVmvA2I59Alz+Tc
	 JR/NzzdDinCBFzoRtIRhhuzgsKNJw4MOEHakv0nHBO+W+u9jmEGCniJUzVbyu2uIvig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fawocRW5;
	arc=none smtp.remote-ip=209.85.210.171
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918CF606A8A2
	for <linux-rt-devel@lists.linux.dev>; Wed, 18 Nov 2026 08:16:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 918CF606A8A2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fawocRW5
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8b58d6f67a5so396599b3a.2
        for <linux-rt-devel@lists.linux.dev>; Wed, 18 Nov 2026 00:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794989809; x=1795594609; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n/X/ib+QXW0aM8E5khBCUAfePu160JSALCSJ/A5VZrw=;
        b=fawocRW5wzdWKgKVD/dpmTTNychhddzao4DwePjMAVZDmVvlQWSd515/fXfVQv3i9M
         6U0M1aPKGsEZ98eRDMlB6OvqILWq4enn1DFCTGVI+Fzb1JmsXgAMgLh+7bncZBPtnRuU
         U0q+z1yv7Ue8P/eiyuoPX7HrPfST0iGwQLhBaL8RfUi7Y8w5D5JezkXPw4LkJJHeCcLX
         C2JQjyoN/c2/UIwvdEoH/rfnAAF7oAzGej6/aCLH9oR5FeiYXepuBp3pvNnKvkn9B/26
         cub9USHoombayNOzb4kAIP8GSpjDGVVcf1oC3YkuC+9hLv+r/5ckjdTne0Izux5NYc1+
         FALg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794989809; x=1795594609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=n/X/ib+QXW0aM8E5khBCUAfePu160JSALCSJ/A5VZrw=;
        b=dHxig6uV2MWystLjXC7tk6QNr2k6fvSQAjE66AzA5FZB99YaQbEBPOK9P1tK+GDDXB
         +kYeNw/ZrGpohYFX+VLIjW8kw8u+9zAc1JLIJBz8bus9H76WZNHXQoMWfvyAnA78VLrA
         uAjeUOfhNnWk2/45pLUG6Yna2DQBDrzp8XPSgVaKa1OcyH14OwXpsfMbYQxd4yopXDVQ
         P2KE292tU7+Jfyti+3pVAhPyx0Ej3V++uoF3lPhQPnDJqbp7lGu5HeY0sndHy+c1FJGt
         HIm+lv+ZrOhrAgRYXk07dU3sLY9VSpz5d7345Mg5BCGVMrCDkW7karzP9ilHM3zTMWUX
         9uqA==
X-Forwarded-Encrypted: i=1; AL+hErEGvEeL/phqAozXQRItvgNSs2o61aazWOG0C5+Q8fsceo2Dvt69aFxea6zvcGW37h6tffvppuCsVUO4qTYL9g==@lists.linux.dev
X-Gm-Message-State: APuU4Z9QyMWs5dCOZGm9e3hLOP13VLLbPB6sCDAXePeittAsFbaKAmUQ
	QOKw7al1tNwTnqgrNigovtm8n1tq63RBMtcuoz9lQgR9popPBrtYvbYORvVTDA==
X-Gm-Gg: AYBFou24BTN3K9vyy/frqJLrXC9dwhW7yq4kD0fXkuacU8XqyzBdt9od44PTNrwUNwu
	/m7IhI/6q+Jp68Z/XQrLo9h/zAz02QNCU7MlsKy2K0IfWXeld3MnzCh6Uh/NaGnsQ/SIcAXpCT2
	YVFEsEhUFv45dXcI69U0HKKTHpeCxouOX5K3VB5XcM9Xr+7PfN2DNzk8XngkkYySa04HwZ9aEXm
	RxnIGqklrPcFDTQLR6XTs9grnil3qId2LthftvbvDmhG7mi11X2shyr9KBtx0bLD+TW0lSfr5Zo
	nAoeA6d0c+SZ9C557ALhlE/eJH47jXw9mZ29kOb5dgKz4tJVyIwGxcF9RIsCzRoK+Y8MfvwnyKh
	GOL25HsxLxTExBmd98IYeNu9kD8XvPn90/VzD2VcMMeerc77KKJ6Uee/85tCIP+Ukyg6b6CjUMM
	Ea4yd1X+UaowEdX5qb7wQSXJ9UkedB922HERHVYWSJ2r1nI6paM0q3MKto+lkwG92fi9ibSm5my
	MkS0PFCYgY5LTU6rA0S7Bxtb9N78V3mkE69t84rfKrXE0p0ebUnKVJVqCB1a9WxdZsR9IcGtqnT
	DWR70UrXNKaDBQj771mDnAjiLUq281GlhsBxua8RwMoYdpOOFmorKQ2/tN5ekZPBtjdF/9A=
X-Received: by 2002:a05:6a21:7a8b:b0:3de:4516:27c9 with SMTP id adf61e73a8af0-3fe988f72afmr1918544637.64.1794989808851;
        Wed, 18 Nov 2026 00:16:48 -0800 (PST)
Received: from hcdev-d520mt2.. (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c5cad8cefbsm764401b3a.31.2026.11.18.00.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 00:16:48 -0800 (PST)
From: a0282524688@gmail.com
To: lee@kernel.org,
	Ming Yu <tmyu0@nuvoton.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org,
	Ming Yu <a0282524688@gmail.com>,
	mfd@lists.linux.dev,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH v10 05/13] mfd: nct6694: Drop the unused IRQ enable mask
Date: Wed, 18 Nov 2026 16:16:16 +0800
Message-Id: <20261118081625.2399247-6-a0282524688@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261118081625.2399247-1-a0282524688@gmail.com>
References: <20261118081625.2399247-1-a0282524688@gmail.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ming Yu <a0282524688@gmail.com>

The .irq_enable and .irq_disable callbacks only update the irq_enable
bitmask under irq_lock, which is a spinlock_t. Nothing ever reads that
bitmask, so the callbacks do not mask anything. They also take irq_lock
while the IRQ core holds desc->lock, a raw spinlock. On PREEMPT_RT this
is an invalid wait context.

Remove both callbacks, along with irq_enable and irq_lock, and keep
IRQCHIP_SKIP_SET_WAKE. Without .irq_disable, the IRQ core falls back to
lazy disable, and handle_simple_irq() keeps a disabled interrupt pending
instead of calling its handler. The behaviour is therefore unchanged.

Fixes: 51dad33ede63 ("mfd: Add core driver for Nuvoton NCT6694")
Signed-off-by: Ming Yu <a0282524688@gmail.com>
---
Changes in v10:
- New patch. Drop the .irq_enable/.irq_disable callbacks, which only
  update a bitmask that is never read and take a spinlock_t while the
  IRQ core holds the raw desc->lock (reported by Sashiko on v9 06/12
  and 09/12).

 drivers/mfd/nct6694.c       | 25 -------------------------
 include/linux/mfd/nct6694.h |  2 --
 2 files changed, 27 deletions(-)

diff --git a/drivers/mfd/nct6694.c b/drivers/mfd/nct6694.c
index 6b8b951f0166..27e9effd68a7 100644
--- a/drivers/mfd/nct6694.c
+++ b/drivers/mfd/nct6694.c
@@ -19,7 +19,6 @@
 #include <linux/mfd/nct6694.h>
 #include <linux/module.h>
 #include <linux/slab.h>
-#include <linux/spinlock.h>
 #include <linux/usb.h>
 
 static const struct mfd_cell nct6694_devs[] = {
@@ -250,31 +249,9 @@ static void usb_int_callback(struct urb *urb)
 		dev_warn(nct6694->dev, "Failed to resubmit urb, status %pe",  ERR_PTR(ret));
 }
 
-static void nct6694_irq_enable(struct irq_data *data)
-{
-	struct nct6694 *nct6694 = irq_data_get_irq_chip_data(data);
-	irq_hw_number_t hwirq = irqd_to_hwirq(data);
-
-	guard(spinlock_irqsave)(&nct6694->irq_lock);
-
-	nct6694->irq_enable |= BIT(hwirq);
-}
-
-static void nct6694_irq_disable(struct irq_data *data)
-{
-	struct nct6694 *nct6694 = irq_data_get_irq_chip_data(data);
-	irq_hw_number_t hwirq = irqd_to_hwirq(data);
-
-	guard(spinlock_irqsave)(&nct6694->irq_lock);
-
-	nct6694->irq_enable &= ~BIT(hwirq);
-}
-
 static const struct irq_chip nct6694_irq_chip = {
 	.name = "nct6694-irq",
 	.flags = IRQCHIP_SKIP_SET_WAKE,
-	.irq_enable = nct6694_irq_enable,
-	.irq_disable = nct6694_irq_disable,
 };
 
 static int nct6694_irq_domain_map(struct irq_domain *d, unsigned int irq, irq_hw_number_t hw)
@@ -356,8 +333,6 @@ static int nct6694_usb_probe(struct usb_interface *iface,
 	ida_init(&nct6694->canfd_ida);
 	ida_init(&nct6694->wdt_ida);
 
-	spin_lock_init(&nct6694->irq_lock);
-
 	ret = devm_mutex_init(dev, &nct6694->access_lock);
 	if (ret)
 		goto err_ida;
diff --git a/include/linux/mfd/nct6694.h b/include/linux/mfd/nct6694.h
index 69e4652cf16c..2022b8fcc096 100644
--- a/include/linux/mfd/nct6694.h
+++ b/include/linux/mfd/nct6694.h
@@ -91,13 +91,11 @@ struct nct6694 {
 	struct ida wdt_ida;
 	struct irq_domain *domain;
 	struct mutex access_lock;
-	spinlock_t irq_lock;
 	struct urb *int_in_urb;
 	struct usb_device *udev;
 	union nct6694_usb_msg *usb_msg;
 	void *data_buf;
 	__le32 *int_buffer;
-	unsigned int irq_enable;
 };
 
 int nct6694_read_msg(struct nct6694 *nct6694, const struct nct6694_cmd_header *cmd_hd, void *buf);
-- 
2.34.1

