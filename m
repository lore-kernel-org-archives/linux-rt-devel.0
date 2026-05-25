Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEEF35F5E9
	for <linux-rt-devel@lists.linux.dev>; Mon, 25 May 2026 19:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779738588; cv=none; b=me3A8XSxxF8EaobRcxtNlEnf+ZvkhEa6vDGoLfga+E1GVrurPFTR5WewG4dj2muE8Vqp5lZoyJtpM7vOd6r01WBO8bFQ4/q+LXwkvbuOnYDQ7sErpTvWBDxQ4WMHiq+LXyq3AD0M/E0MA53CtxRPyctkaGIHMU6digtTLXGP4DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779738588; c=relaxed/simple;
	bh=KN32dTtmfpBUCNjjKsDJ87Yez5+okt9F+j5uevGUbbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SEqBMpeezboOFjh1B4rQi4HC0nIw70kRDhR+AC6QUbKCsYTT9LJRHEa3yR8ymVzynBV4VN59nSxQJB3NsvNtEsNQfQK+68e7sR1kttL+V2ye1xyeO29A2+4pAuHOKe+PSdwbMWAVw66WicFTtQJLgvS+lejNvf42hGtnytbbeKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=TkIyTHUu; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="TkIyTHUu"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-30246cfd41aso1976831eec.1
        for <linux-rt-devel@lists.linux.dev>; Mon, 25 May 2026 12:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1779738586; x=1780343386; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HR4DFF79sz18rq0F3+mr/LSyfi6B2biymk9ahV0bWd4=;
        b=TkIyTHUu1rdiZnxF1FPdsr9Vqa+eXcuMBsi1Kg/al+vnKhPr58rPsx5J8i42YNoZIP
         D2pBBNJO9XzxaXlhXMJZix5hzn2fbXvIHwYggtju7+rfPRWQ+p0wDZ3q+r7kU9NG14ZN
         d+JcaZFrK1jI803gWrB0xfoSYiIbVTvU0GIBkcI8AkhbUjZgae8DZ/FcbEC33MuDpfrV
         COV8OSdPxN4N0xVwzJ66i858UYUxdWLYKOVgp2Da3g7CRmw+HLEOsgEXNFl1BM0Znsy3
         49dyQflflChoanDHIm5o5kG9GLWrW/m7Zltmi/kj4qLa0/fctSDBc7TdyJjZOu5QEJaM
         LFwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779738586; x=1780343386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HR4DFF79sz18rq0F3+mr/LSyfi6B2biymk9ahV0bWd4=;
        b=kqkTGiPwk3qtsr0PY7Dcded7P4nAShKeKc3v34m8gfc1tFAF1ZZyNt7qWar4pk0Vs1
         J970u/DTEYvwwu4kbMuflfVtvLYckoNrNn0Q4vP+R13IHL5pdsk+nv1vIarRDx6Zb78W
         2izeEpzd7C7rCZm+JCh7DtZCG6FxFk+rqzaXWLo2K0oR02gEUyPjR2A9ajIn1iLYItOY
         bZ+O4sG5qrqLOIU63tXB80nItl5eYAdrFXuzg8q32khvnd3ugYT6JfL82g44qv1Qcu2V
         Y6imrnuGPl23WNsvIa3TR7XkftvITeqOlzwdtq6YRkX85o23EfdM8jeUZ46B14sCSaLE
         vDRQ==
X-Forwarded-Encrypted: i=1; AFNElJ8oSFRFH5rUYIiNIrn5qv25Uzkwl6lPgUK5B/LKPW5/TAC7zUdCPGL+ns2LdpJ87ITiGNhvN5kF2Ry9FXG53w==@lists.linux.dev
X-Gm-Message-State: AOJu0YxVyuTBhPpgH66nyjCSt4kHAYKbOW7PP1CczKnLhWOLgGCUz3hS
	wSF49zC42n1C7ljPqs9c7drYo1pvWplUAGTI+uJQk5OIrm3TdcKNmltdoNdBcu/BmBY=
X-Gm-Gg: Acq92OFSPPn+vLPT+xWQm7RWAnYnoiJo2tKMD+ekt+yk/biVUX3oZ/4QXF06inRP+1M
	rBnpMaEMo59kSIgvI5yn8NERz9xxKOBdJsZAPUZWYw11yoXriiFPJxBAwOHlRAigiRMvTm3JHpf
	nxBgsf+apLeyrPjx7aFAT4I3eoxNqtR78CGZnxLIz8d7OvcOOW3Nqu25scrHQ893KoCTWUcbQyD
	imkcwFzb0UzWFJlVkyiYu5uVnLDZ0krzT7XrGpCWz3CfhmnbqQZE3kqqUgrmHE6dc++0Qcqe2gR
	uvqByrg0nwjw/wMha2DJaGuc0i6mUqGAphFWT9qOyTJN0vFeRumTWZIKRJbEbI0mysKWSRCpNVE
	rRcjo6TkesaVKRhZzbdmsU3Z/FAq7emzN6pE4BPiClY/nc87jarlJgGKCrCRTClJc7d3crL4Skl
	3UApCZJUgzIozzctvEZp/PuuV7Hv+RGeX/8G1O
X-Received: by 2002:a05:7300:509:b0:304:6782:d5a4 with SMTP id 5a478bee46e88-3046782e5edmr5137811eec.5.1779738586400;
        Mon, 25 May 2026 12:49:46 -0700 (PDT)
Received: from mozart.vkv.me ([2001:5a8:468b:d015:2feb:307b:ed4b:5f1d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30452230dddsm11032141eec.17.2026.05.25.12.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 12:49:46 -0700 (PDT)
From: Calvin Owens <calvin@wbinvd.org>
To: linux-kernel@vger.kernel.org
Cc: Rodolfo Giometti <giometti@enneenne.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michael Byczkowski <by@by-online.de>,
	Eliav Farber <farbere@amazon.com>,
	linux-rt-devel@lists.linux.dev,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH v6 1/3] pps: pps-gpio: split IRQ handler into hardirq timestamper + threaded handler
Date: Mon, 25 May 2026 12:49:30 -0700
Message-ID: <106de17aabedc07c3550a2297c1659ef97f28c41.1779733602.git.calvin@wbinvd.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1779733602.git.calvin@wbinvd.org>
References: <cover.1779733602.git.calvin@wbinvd.org>
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
index 935da68610c7..f37398fd6b10 100644
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
+ * Primary hardirq handler - runs in hardirq context even on PREEMPT_RT.
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
+ * Threaded handler - processes the PPS event using the timestamp
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

