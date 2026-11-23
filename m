Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795438991;
	b=ehS8LAgfn9RKri6lTh6wU8QyYZ1VWBreomrPbdIsKLpLFIlfOKeUh+tPUqK1KzJyrUQM
	 OfUZQm3lTX99I4uQgvSMA2AybxMTjpFRPM/Is3m0xGYi8ooUlmyWgPOB53hPDSy4007MP
	 Vzt8jM8swaju7JU1ihAngCJ8X851cDHn1AdWI0opPKzTDGsSTb1q5S6vum3Hq4brW/6yp
	 Maq87IZ54351wGsGV/jBOSX19bJ+cVe0ULcQt5aeHHCM0/yjhCnd8gk0XMfw/stGwcFkq
	 H4RjxIDwAeMad4OnLo1td4MfAAdx37exerHaeEBBvypgEetzrthzuBnbuQNUQ1rBbAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795438991;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=wg5SGmS6BijniY97uk+aTHYyvR1onjkeuDeP3BvWyrY=;
	b=YCwLVT9RFOjHp9Jd9J4apS+M8pf1PGvceJQUfAho5c3gRQWm7JndncCtdXZd9ldZt6FJ
	 c0Wcxiu6TZxxxWGHYxsgan1zIkwkGusUnYlNJomVLHTicuwlQSs2gom3eeBbEJmL/HW20
	 CAt0ZOkVXA1rMtdA3JRJCZVy38lTUYtzmrkyH41lUa0qkkDhR5M5hc5anxinO9KNUtgTu
	 P0/XOenC1hh7ef3x/++Tv1/atrP+/IF4FHShhmeJFu48OAB5lYYojb+PRLCNckG+uEert
	 WvcOI6L1HjtU0FGdV9FdV0Qj+9A4g2IP7fQLLe+JqcCU8NQg7yFzsypsvP/XUpqDHrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=J6NSxUXi;
	arc=none smtp.remote-ip=209.85.218.41
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C29606A32E
	for <linux-rt-devel@lists.linux.dev>; Mon, 23 Nov 2026 13:03:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2C29606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=J6NSxUXi
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c4395d31228so520156666b.1
        for <linux-rt-devel@lists.linux.dev>; Mon, 23 Nov 2026 05:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795438989; x=1796043789; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wg5SGmS6BijniY97uk+aTHYyvR1onjkeuDeP3BvWyrY=;
        b=J6NSxUXim9Dwq5AnCNhdxtqaCu1RB/h0NTcpCbaLBWgO4tEmqCWTK5klFYOlll/GNF
         i3XlkyX3umdw6D3OzJeHqK69aPTSxGCBHwkRBYlLWzdOINGATIdM764zmjEE6lt2bKQK
         ouBCVxd746DC6T/G96lmpv2KrmIuy3Ha1XvERIkIisS7eipVgHIXuggR/zUbVzoueezS
         9ebwAuU8eh9vvfjDMcdtLp1f28tWdTBVD6rrMCWt41ldDOTqbsxTBQffCxvPMMdvxERe
         vIg0W8N1qeC9SphZiMTTl0jP1fqleo/HNlNckxdbCzs93IigkfeVUvZC65a/Bh7dAGQo
         z8zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795438989; x=1796043789;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wg5SGmS6BijniY97uk+aTHYyvR1onjkeuDeP3BvWyrY=;
        b=m9J0mEj2GYOcKgnK+8ghEB9LuWvwgnbH3B19UyQkIA0OReIxTz95vcgxfjX4kJywr8
         1ad3pE2YYaqEWsKqRubWedx2Dr4JDv+6lCMgu/r7+TEV+wxExLFgYwAXZzdrLxh+5TrJ
         DmFfbnq+0OyC0dOFpaW1OlvzrQYPkIj5vzphB4uEKcBDHznJV+5t3PoWv6MuweKw7rQC
         1yNgpssxVn+ZcuoUWijjfFvreCA4Cbhed66sLo0p7MWbVBN+wU1lm9uXD8u92B5hh4sx
         fXj+Y6gtzVzMvTJybBxC2+hpkBX2XLmaBPQ3eJPKkY/nRw9Y0E19+gM/JqqJpd6xGLFV
         e9rQ==
X-Forwarded-Encrypted: i=1; AL+hErEExi6QwCGiXSGEaHGFPb8257kC4bzYRwx19PLQ1nTjcAV/eoqMQYkA432o4PClbPCf9zsCZDLdek7NZV076w==@lists.linux.dev
X-Gm-Message-State: APuU4Z95Dm4cc5mThBtM7aZDxdGuv8jMTAKPVXyRGTkXjYguy9rj4REW
	upJ5JMN0eU3/dX0QjrtE9eqj722cDlogWuQSafO9Z6lnQbLU9rsuc6vlBsmmpiobyvo=
X-Gm-Gg: AZFdTZem6URgk/tH3JJsBrtDea3cPv35lR/MclYdBUTebQU2+n8VLqnI6iEFDetkSLL
	6/gjv2OH0DM3PnetoRReE7EXuRoSbSDSauLj8p2wM8V8ZB8q9lOJO3qZsL+II9cOQZw7ONrrJ6J
	9Xj8fH6LqExDIfw3Wpre1bltbaGwzvIQlKh0SOciKzh5bJunf9Vm3LBNCWXnAkOYAtzwnJQ8wmy
	KeC9bbJY3prjxZb0yKHOZUI3C1XhJZdb4167ZX5t69bv8AohW68ixCB50GpCWNsR/WGAL8LA1zR
	e150rOolsG4JkHu4vkAvQbqwFxqO3+9UKiQugC/dM01AdhOYes7gCtzFZBrVMViWKp6O0mGRrAb
	icYrHbsoILVuYowecOzeoR8Ls0nke/F6bt/PcaHQxGVwq4FDYjd+LukfpQcGvN6ZWhp5mmwadNM
	Rxuv9e70huobO0XOI2jp31YcWaIQhUuM7G3+M45wLDyPRIT9jY0WkZnzCuMMqnukKJUwsAxjQLi
	vh0lSFRPD4j5GL9QjUx7WpdP6h100exrzWF0vVN/8kThZ6t2h7ir/2aTANSKKfxPsHnUKudrtAB
	ZT+lvrQXkZBAj0oqzYchC6RqSGYfx0Dx0JHTWCBuoUT9QdQkkrJ0l/rrfW1KUKxjJe3cvDXRyGg
	WiiZMEDHiVtyFspKwXw==
X-Received: by 2002:a17:907:a88f:b0:c46:d493:501a with SMTP id a640c23a62f3a-c513a8410d9mr998124466b.22.1795438988978;
        Mon, 23 Nov 2026 05:03:08 -0800 (PST)
Received: from puffmais2.c.googlers.com (226.124.90.34.bc.googleusercontent.com. [34.90.124.226])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afe85ecsm401379466b.70.2026.11.23.05.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 05:03:08 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Mon, 23 Nov 2026 13:03:06 +0000
Subject: [PATCH 1/2] usb: typec: tcpm/tcpci_maxim: fix invalid wait context
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261123-max77759-wait-v1-1-6fa54a751bb7@linaro.org>
References: <20261123-max77759-wait-v1-0-6fa54a751bb7@linaro.org>
In-Reply-To: <20261123-max77759-wait-v1-0-6fa54a751bb7@linaro.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Badhri Jagan Sridharan <badhri@google.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, Juan Yescas <jyescas@google.com>, 
 Amit Sunil Dhamne <amitsd@google.com>, kernel-team@android.com, 
 linux-usb@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3

Lockdep reports the following with CONFIG_PROVE_RAW_LOCK_NESTING=y:

    [ BUG: Invalid wait context ]
    swapper/0/0 is trying to lock:
    (&dev->power.lock){-...}-{3:3}, at: pm_wakeup_dev_event+0x38/0x80
    other info that might help us debug this:
    context-{2:2}
    locks held by swapper/0/0: 0, on CPU#0
    Call trace:
     _raw_spin_lock_irqsave+0x60/0x98
     pm_wakeup_dev_event+0x38/0x80
     max_tcpci_isr+0x2c/0x58 [tcpci_maxim]
     __handle_irq_event_percpu+0xc4/0x4d8
     handle_irq_event+0x4c/0x100
     handle_level_irq+0xe8/0x188

max_tcpci_isr() calls pm_wakeup_event(), which acquires two spinlocks
(spinlock_t): dev->power.lock and the lock of the device's wakeup
source. On PREEMPT_RT, spinlock_t turns into a sleeping lock. Since the
interrupt is requested with IRQF_ONESHOT, max_tcpci_isr() is never
force-threaded and runs in hard irq context even on PREEMPT_RT. Taking
a sleeping lock in hard irq context is invalid, triggering the lockdep
report above.

Move pm_wakeup_event() to the interrupt thread max_tcpci_irq() instead.
Drop max_tcpci_isr() altogether, since its chip->port check is already
duplicated in max_tcpci_irq(), and request the interrupt without a
primary handler.

Note: Moving pm_wakeup_event() to the interrupt thread doesn't allow
the system to suspend before the event is reported:
suspend_device_irqs() uses synchronize_irq() to wait for the interrupt
thread to finish, and pm_wakeup_pending() is checked after
suspend_device_irqs() returns. Once suspend_device_irqs() has armed the
wake interrupt, the interrupt core reports the wakeup itself and
doesn't call the driver's handlers.

Fixes: 6f413b559f86 ("usb: typec: tcpci_maxim: Chip level TCPC driver")
Cc: stable@vger.kernel.org
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/usb/typec/tcpm/tcpci_maxim_core.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpci_maxim_core.c b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
index a19f52515429..6e202171f57a 100644
--- a/drivers/usb/typec/tcpm/tcpci_maxim_core.c
+++ b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
@@ -411,6 +411,8 @@ static irqreturn_t max_tcpci_irq(int irq, void *dev_id)
 	irqreturn_t irq_return = IRQ_HANDLED;
 	int ret;
 
+	pm_wakeup_event(chip->dev, PD_ACTIVITY_TIMEOUT_MS);
+
 	if (!chip->port)
 		return IRQ_HANDLED;
 
@@ -430,18 +432,6 @@ static irqreturn_t max_tcpci_irq(int irq, void *dev_id)
 	return irq_return;
 }
 
-static irqreturn_t max_tcpci_isr(int irq, void *dev_id)
-{
-	struct max_tcpci_chip *chip = dev_id;
-
-	pm_wakeup_event(chip->dev, PD_ACTIVITY_TIMEOUT_MS);
-
-	if (!chip->port)
-		return IRQ_HANDLED;
-
-	return IRQ_WAKE_THREAD;
-}
-
 static int max_tcpci_start_toggling(struct tcpci *tcpci, struct tcpci_data *tdata,
 				    enum typec_cc_status cc)
 {
@@ -538,7 +528,7 @@ static int max_tcpci_probe(struct i2c_client *client)
 
 	chip->port = tcpci_get_tcpm_port(chip->tcpci);
 
-	ret = devm_request_threaded_irq(&client->dev, client->irq, max_tcpci_isr, max_tcpci_irq,
+	ret = devm_request_threaded_irq(&client->dev, client->irq, NULL, max_tcpci_irq,
 					(IRQF_TRIGGER_LOW | IRQF_ONESHOT), dev_name(chip->dev),
 					chip);
 	if (ret < 0)

-- 
2.56.1.750.gf70dc682cf-goog

