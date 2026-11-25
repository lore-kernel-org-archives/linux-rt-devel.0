Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795609031;
	b=fgRpIdTGUGP5J1OwpeCbmUfFdFvpINBf1RZcHj+tNudivY2Efa8L7FU7TAiageO9LRXE
	 Lf3uaZ99w1fGul2OMug7e8Z8lYAg1mTiaOpkTVU2gPaI5vEIoi+Zo79mx2vgePwY8wqMo
	 NEcrOjVWi1JuicCucnT3+wvo6DPhVGwBnsr6BF66It2svtCGuG/OQBfwrC/5/8U9Xcvjc
	 WGwxcK1gQ6JFHyDTTbQ+n095NtY9KqfowPAq+498ONhjGolPq6M/jtrsNzn9UvQW0Dm+V
	 0Ff2u6k2uJOdI88t4Qi9+tnOnXBx8SSBG6r/Ql4zkG3PQ0rZn+d2Amp2kIdSlL4wrWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795609031;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=Rulwleyh8bhvWAVb0QvlMS6II3FShQUJjsRscedmHGw=;
	b=o1NpWNwPyiP7qxrYdHxkGXmvRaWGJCfAPaqskaO2Ppo7cHH/ZIfZiy3fW+u+Q4JyLtsD
	 oirE6Cf1WhtzAnyQCAY4OtFrDK/j5eR3MfD+Iwz8/30hC/cwlkY57cq+vd9xlQUM4kiMs
	 EynWcChYlZbPTU8TAmj8dfLPmp+xX/K+8T6bHvRCnmnCc4KN2SofSYvvqLr8s5JwwKFgd
	 gx8hcHlYQphz5GcX499RJDBYJ4LErJacOJ/ijJAYnZER4lTFtCvkBMJzQJm1X7ZjAncbD
	 KaQbdKSWSg27oXE7IETTJ0jzt4l7I1Fl6LIkUzppFNotM5dzoXOUgOp55lp2Yr/g3DA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=h8DFb1nk;
	arc=none smtp.remote-ip=209.85.218.54
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B82F606A331
	for <linux-rt-devel@lists.linux.dev>; Wed, 25 Nov 2026 12:17:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B82F606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=h8DFb1nk
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c506a231b88so774063366b.3
        for <linux-rt-devel@lists.linux.dev>; Wed, 25 Nov 2026 04:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795609029; x=1796213829; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Rulwleyh8bhvWAVb0QvlMS6II3FShQUJjsRscedmHGw=;
        b=h8DFb1nkZOeYiXJAv14NpVK1qKiU1kBrV02BBQWx1Ql/Fvz8P9622wrrZ1vIQGXVD4
         7Yzo/rBVzWJX5CGm6A/+fbObJW4Dd+ejuD5cJatZ7HepXkJOFAG8CoyxjCTwlfaPJQKD
         FCEpzzDtTj273OWezcXkxXGQXJunOul0ymlwCLX+4/YQa33drwMjaBKeLpS/hDPntESp
         g9QdTrnNEw+LxHRToVpLg31XUiQLUlbtHgEnxTb79EpLqli/G21gpowijiz/D3UAp2I+
         M2/J76a8Hi4pmRaA8m+QdKrY5w6jOfoPswYFohJaAH8eahBMc0L/vEreScJpWXNGg+ty
         oHng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795609029; x=1796213829;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Rulwleyh8bhvWAVb0QvlMS6II3FShQUJjsRscedmHGw=;
        b=L9YFco6LQhh9YgLRphxIRx7keBuL2qbMCpWDCAy9gVqy9FEXYstA08RztsSELtm41l
         b7R2jSUjr86qbNQFzgzs+vYjXx4vTzE6VD7VQFdzrK8Ilzxc9K+51GXKU5mwdFqjlugk
         /22FWJIU8oRADE61oQPEs2142yXguoRlMSwGBLH8R2ACM15MpZVvRrQL/ztlLZyJ+ssw
         mRVmjaMsUl8D4KaGz4qrBadyj1q+TloLyEDqebKvWpfQm+iGgwyRStTlB604AQkP2ctG
         B5t8/ZAU6ndRQQ1Sq4zNHK3J4azCSiSJHuoBC9sUO0NLASV4VmURK7F421vvR5WkPgMP
         puGQ==
X-Forwarded-Encrypted: i=1; AL+hErEfu4Y59sYcrdNHOp38N6uDvElhJErkD5S/ZIkP4ZYedVbhnZhjUZWvVfp5y85OrGtpl9XPrnBK7yGN0bRpBQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z+kXu67dN7R5+3dhaJvSYT3gXEYr3oysCduPcYuPpxivlxzG5J9
	VezV0QtegNWxVlWp/iectGKMpkab4hYRQkFzDVKEZk/GkXQWNWJ/vRRo51xiUdwhOfg=
X-Gm-Gg: AZFdTZf4hHydcAuxsYmB6vQy3hvwKgTrl9Vy2iNxclo2umKhQ9asMZ/mxWN/SIK+d/l
	eRigDHL0LK/q4nrT/42054Z9QodP5ICpueJ2+y756yumX6A/DRZpsLenOWZoU9pHUn8hWZRjO/k
	h+CEDOz9n/OLrQrDQTuE3ELWhDSGiVNI300eHm94S+AYa8z4rsZ/vYBVT3G3oT2vqSb76Bs02+3
	Z7Gt0djA626xj7mdYy29rn+K1qGJ89RzijePpVECkoqB8JAd/2ASv3jF2wKj4rcsABEUyBzeQMQ
	6l02P/d3+udlYpACcy+NQie7hKkM1qJJwCYnRdbUqXRdWTUNhzd7+KnIT/IOwaRlTLiLyv9Y5zU
	eAIUALaBAkSa6A50ufRwg/Jff74fClsTb3WsB7WONG19EhFuwpajcpttrbZi/j3/D85iGHiMDEb
	KH1Xna7cABAfECZCuUh+8M77L8P/J7U7TjtJNHvEwsoNd6XOMlYCtdpHKj2fsGoN6i3Kj1oc4KT
	0p+XllfhGQtGnTQsDQ/tGRop/hbMvyIMc7I5QJI6LpxUC/HiM8hNamQRHN1Fwc+I1A7mQ06q7+u
	glGogDMAHiOHU2MUX8082Dy347mWrkQa4lR1Zc9Cn9UvBb7TjJSLX1BbHVX/kzrXLc2y10EUC62
	mxhBB0LFOccGYrwXoyg==
X-Received: by 2002:a17:906:a11a:b0:c4c:d96e:80de with SMTP id a640c23a62f3a-c513a5dabbdmr1120945766b.8.1795609029062;
        Wed, 25 Nov 2026 04:17:09 -0800 (PST)
Received: from puffmais2.c.googlers.com (226.124.90.34.bc.googleusercontent.com. [34.90.124.226])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513ad00d2asm650611966b.3.2026.11.25.04.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 04:17:08 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Wed, 25 Nov 2026 12:16:56 +0000
Subject: [PATCH v2 2/4] usb: typec: tcpm/tcpci_maxim: init wakeup before
 irq
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
Message-Id: <20261125-max77759-wait-v2-2-9914b985c00b@linaro.org>
References: <20261125-max77759-wait-v2-0-9914b985c00b@linaro.org>
In-Reply-To: <20261125-max77759-wait-v2-0-9914b985c00b@linaro.org>
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

max_tcpci_probe() requests the TCPC interrupt before it initialises
the wakeup source of the device. Since the interrupt is level
triggered, an already asserted alert can trigger the interrupt handler
before devm_device_init_wakeup() is called. Its pm_wakeup_event() does
nothing while the device has no wakeup source, so the wakeup event of
such an early interrupt is not recorded, meaning the system is then not
prevented from suspending for PD_ACTIVITY_TIMEOUT_MS while handling
that alert.

When the driver unbinds, devres works in reverse order and in this case
removes the wakeup source before it frees the interrupt, which leaves a
similar window.

Call devm_device_init_wakeup() before devm_request_threaded_irq(), so
that the wakeup source exists for as long as the interrupt handler can
run.

Fixes: 6f413b559f86 ("usb: typec: tcpci_maxim: Chip level TCPC driver")
Cc: stable@vger.kernel.org
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/usb/typec/tcpm/tcpci_maxim_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpci_maxim_core.c b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
index 6e202171f57a..2bb306b6b1f9 100644
--- a/drivers/usb/typec/tcpm/tcpci_maxim_core.c
+++ b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
@@ -528,16 +528,16 @@ static int max_tcpci_probe(struct i2c_client *client)
 
 	chip->port = tcpci_get_tcpm_port(chip->tcpci);
 
+	ret = devm_device_init_wakeup(chip->dev);
+	if (ret)
+		return dev_err_probe(chip->dev, ret, "Failed to init wakeup\n");
+
 	ret = devm_request_threaded_irq(&client->dev, client->irq, NULL, max_tcpci_irq,
 					(IRQF_TRIGGER_LOW | IRQF_ONESHOT), dev_name(chip->dev),
 					chip);
 	if (ret < 0)
 		return ret;
 
-	ret = devm_device_init_wakeup(chip->dev);
-	if (ret)
-		return dev_err_probe(chip->dev, ret, "Failed to init wakeup\n");
-
 	return 0;
 }
 

-- 
2.56.1.831.g720f3f5937-goog

