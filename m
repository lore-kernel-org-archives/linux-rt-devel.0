Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D6C2571DA
	for <linux-rt-devel@lists.linux.dev>; Tue,  2 Jun 2026 00:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780361061; cv=none; b=hV43zb0FPgfwa7zfKOK2DrbNjxTP4VpX0v/jrxMoHxLOW/n+DppWJBcHk4dgDlF9TUIqBdznlgeDnCweZENUrQrOLdK0NtsTiXlbyCAJ+a00dYUiBSHu2UFZhcgMZMZMs+iisIxdEofqukQT52DNETn/XM+EEPRxY7e2n7FKYko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780361061; c=relaxed/simple;
	bh=0LUonfPrE1kWtwRfsjkmrwfwIRLeDnNvuJNsHEeDqZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E2mlutQ3QfD+ME+fDqHB3FlrFi9MFZ0lt8hJKkGIiS4cWdPYn+okb6voDPoBu5hUMMrafRhBv2GPzdKIqVSCtw+tKavV5f8ZtQXbYHoSxrpJ0OhfzTb1f3noRqu7x4zXAFzXbzM73RYwGMr+iKBTDabKhKtroFXwRzpZrCWI1TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=YS+shDP8; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="YS+shDP8"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-304f590dd91so3251607eec.0
        for <linux-rt-devel@lists.linux.dev>; Mon, 01 Jun 2026 17:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1780361060; x=1780965860; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VanU0jfd0XG0PBJ3m9uemoc4Gb0wVkw7ywXii/IfKnY=;
        b=YS+shDP8J+kzY0updPUbS4L+nC8r/YhPDboEFIhhXRgpO77oF/jTS0IyxBANkFoUu0
         Y5isCE/NjK03ehR42BQS1kHZjuuvBEmOivCU8CYXmCxb/HzZmttCyodMaROdus7bpDB4
         QFEkXEgj28CwkFlwM8EbMYg5cYPf8aHvBPZTGYtdqCCEkck6Etpk/oB6/fH8gu8xtsdx
         wF3vws4y++4TUV+rEu7MXmXPEK3ToeXSrVjdkMiQhOOfRzeBAulDmS0GqQl4cNoPCUX0
         SiX8HwwJLdY285lyW70UfMPQBF8rEWbOX0YumRWBYuLnywRjndV9eBR8rRKKBiqYvoOr
         mMTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780361060; x=1780965860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VanU0jfd0XG0PBJ3m9uemoc4Gb0wVkw7ywXii/IfKnY=;
        b=IHjN7duKAmAF5PC2hVxcPNr8lpJzx1GMiuS6nLZ0+SXF5aDwW2Y4f2RhKBkqUx2YN8
         iANZ4/41JpoNLJhlTn2nPKJNvK+z6ps/ZRPBFeC1At8lnhMB7MvCY4wVUg1MHVDZbTCw
         Nx5zyGwBIj6UwQf2dq7kN9aTMDUUeK06ETqWidFwqtnFQZ6JE+YTycNlGuoXPWEzuEoX
         2eV+LrpR2minB15kCLPFhwP+/1sbSKoxYVcRSexDPLUOif6Xe5JR7lVkPf3YnJ21Eexa
         HUmXmqJ3+AfhC2kKdHx9Jx839sLM4mZ/SuLHwkuayymf/uRYNY6R+EAxnI8XF4QBtArd
         ZrGQ==
X-Gm-Message-State: AOJu0YwsxCaCV/QBlbZHvI2svOSZw1TPT8da6cp+lORtrivOh0iineSW
	kpknPXJ079r4hvaC2aTdMoB36kxQHpWqaRyekn7NBoPVXls2TCqFAxa5g0YZkH4SdE4=
X-Gm-Gg: Acq92OFZq3xwB3hXEvR+e114mGn8yw1rNFFrmnu2r4yfVbssoH+298h2+nJRH0nPApA
	ut8UcX/5CDi2NAUtwls4tl/rJNo2Vy3FT02XE84KZIRChkK6oe/rbzr8uIQbDBHW1vC9Hl88BnP
	V6EoW6/cMowZJQtELkQ967uv9CaiwpYOdnm2joRV83W8fBxsNPV0xeo2RZPWmRmhgALtRu8hhno
	8VJXelhFIyOgTR43i2eDXphh9c1XsQ0/IEWMizjG925ks1WrTh43/tRv08LGuB0gNIWqKDZ073v
	mIBPyM9UZJbeTGXqMaXy8tu8YU2Gq+/VmvcCp3sfQTZGlrvR/IuvM2Qi8rllGHonZAN79FovhoR
	GeMiIu5CN5aX3k3J4NvavI2H4C+TsvuZQl4ojw9FHYUZuHC4aXxNZv28067MpuoPlIfG9n00P7D
	9of3UNwtgsT3DpM3Ys9LQkIozUszBPv97AykpT
X-Received: by 2002:a05:7300:724d:b0:304:bce9:25fa with SMTP id 5a478bee46e88-304fa525843mr6102312eec.4.1780361059611;
        Mon, 01 Jun 2026 17:44:19 -0700 (PDT)
Received: from mozart.vkv.me ([2001:5a8:468b:d015:e55d:f6f2:1f67:2056])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed2c10c1sm9892762eec.1.2026.06.01.17.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 17:44:19 -0700 (PDT)
From: Calvin Owens <calvin@wbinvd.org>
To: linux-kernel@vger.kernel.org
Cc: linux-rt-devel@lists.linux.dev,
	Rodolfo Giometti <giometti@enneenne.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Eliav Farber <farbere@amazon.com>,
	Michael Byczkowski <by@by-online.de>,
	Ingo Molnar <mingo@kernel.org>,
	David Laight <david.laight.linux@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>
Subject: [PATCH v7 1/1] pps: pps-gpio: split IRQ handler into hardirq timestamper + threaded handler
Date: Mon,  1 Jun 2026 17:44:09 -0700
Message-ID: <2e32729029fbf6977ecf04665eb00f2efd3e2c17.1780359378.git.calvin@wbinvd.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1780359378.git.calvin@wbinvd.org>
References: <cover.1780359378.git.calvin@wbinvd.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Byczkowski <by@by-online.de>

Split the pps-gpio interrupt handler into a primary (hardirq) handler
that captures the PPS timestamp at interrupt entry, and a threaded
handler that processes the event. This produces the same two-part
handler structure on both PREEMPT_RT and non-RT kernels.

On non-RT kernels the threaded portion runs immediately after the
primary, with no behavioral change compared to the previous
single-handler implementation.

On PREEMPT_RT, where interrupt handlers are force-threaded by default,
the previous single-handler implementation captured the timestamp
inside the threaded portion, after IRQ-thread scheduling delay. With
the split, the timestamp is captured in true hardirq context as it is
on non-RT kernels, eliminating a significant source of PPS jitter on
RT systems.

Tested-by: Michael Byczkowski <by@by-online.de>
Tested-by: Calvin Owens <calvin@wbinvd.org>
Acked-by: Rodolfo Giometti <giometti@enneenne.com>
Signed-off-by: Michael Byczkowski <by@by-online.de>
Signed-off-by: Calvin Owens <calvin@wbinvd.org>
---
 drivers/pps/clients/pps-gpio.c | 37 +++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/drivers/pps/clients/pps-gpio.c b/drivers/pps/clients/pps-gpio.c
index 935da68610c7..ed111621ee5f 100644
--- a/drivers/pps/clients/pps-gpio.c
+++ b/drivers/pps/clients/pps-gpio.c
@@ -35,33 +35,44 @@ struct pps_gpio_device_data {
 	bool capture_clear;
 	unsigned int echo_active_ms;	/* PPS echo active duration */
 	unsigned long echo_timeout;	/* timer timeout value in jiffies */
+	struct pps_event_time ts;	/* timestamp captured in hardirq */
 };
 
 /*
  * Report the PPS event
  */
 
-static irqreturn_t pps_gpio_irq_handler(int irq, void *data)
+/*
+ * Primary hardirq handler -- runs in hardirq context even on PREEMPT_RT.
+ * Only captures the timestamp; all other work is deferred to the thread.
+ */
+static irqreturn_t pps_gpio_irq_hardirq(int irq, void *data)
 {
-	const struct pps_gpio_device_data *info;
-	struct pps_event_time ts;
-	int rising_edge;
+	struct pps_gpio_device_data *info = data;
+
+	pps_get_ts(&info->ts);
 
-	/* Get the time stamp first */
-	pps_get_ts(&ts);
+	return IRQ_WAKE_THREAD;
+}
 
-	info = data;
+/*
+ * Threaded handler -- processes the PPS event using the timestamp
+ * captured in hardirq context above.
+ */
+static irqreturn_t pps_gpio_irq_thread(int irq, void *data)
+{
+	struct pps_gpio_device_data *info = data;
+	int rising_edge;
 
-	/* Small trick to bypass the check on edge's direction when capture_clear is unset */
 	rising_edge = info->capture_clear ?
 		      gpiod_get_value(info->gpio_pin) : !info->assert_falling_edge;
 	if ((rising_edge && !info->assert_falling_edge) ||
 			(!rising_edge && info->assert_falling_edge))
-		pps_event(info->pps, &ts, PPS_CAPTUREASSERT, data);
+		pps_event(info->pps, &info->ts, PPS_CAPTUREASSERT, data);
 	else if (info->capture_clear &&
 			((rising_edge && info->assert_falling_edge) ||
 			(!rising_edge && !info->assert_falling_edge)))
-		pps_event(info->pps, &ts, PPS_CAPTURECLEAR, data);
+		pps_event(info->pps, &info->ts, PPS_CAPTURECLEAR, data);
 	else
 		dev_warn_ratelimited(&info->pps->dev, "IRQ did not trigger any PPS event\n");
 
@@ -210,8 +221,10 @@ static int pps_gpio_probe(struct platform_device *pdev)
 	}
 
 	/* register IRQ interrupt handler */
-	ret = request_irq(data->irq, pps_gpio_irq_handler,
-			  get_irqf_trigger_flags(data), data->info.name, data);
+	ret = request_threaded_irq(data->irq,
+			  pps_gpio_irq_hardirq, pps_gpio_irq_thread,
+			  get_irqf_trigger_flags(data) | IRQF_ONESHOT,
+			  data->info.name, data);
 	if (ret) {
 		pps_unregister_source(data->pps);
 		dev_err(dev, "failed to acquire IRQ %d\n", data->irq);
-- 
2.47.3

