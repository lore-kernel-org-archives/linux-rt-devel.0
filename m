Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795438992;
	b=NO3AWr6zjtrvoZ7n85VV/MKRh51opUp2nZVg1OPGjH9ngMX/QPTjDzXZSXOhVBwHF2bI
	 XGtEPx58ezWN69d0JkKjBveyz1qt5r1q15ujw3ijl+8W4sMYM5IWrBdhO5ZSXppf/dTNz
	 nuZQ6/5vQMS8RvY9P9ocozjgaPwobFsy5zFgFXeQudfNvpItD3uLPz8WQi8BYF0YHE5oY
	 D7LTgK+WXXR+TNqof0j+Gu4HK6lzbjASKAIa8VuPLo3zVBkH5g1+xL9Z93KfCBTrPch+g
	 7/l6jTe4wRfju9gInovzn4cx2ih4xsH6cJvJU9YYP7g6xpKZ8IFGs/TnuL2tZ3tbBoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795438992;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=mDrXuY6jqpxWSzFXHtwGni325RaMm1gVLFRBB2Xcank=;
	b=XbC/2pOsHWdK2QKvK3VNr9zOMkmJ+EtFV8vu8WM09DWVIiFJtznVEoovzBkznvJ+RwNH
	 LLAkRH22mRuketMExqz0fzwm10+L5F0dM1fOFlyvrpjNIrjBiHxHssYGycQqkZ4O4lRtj
	 u8TbprVx4rQZpx84gVtpwGdyUaNlFFJXffsng06r/EN90eLLBWbXaa+eUnCPVxcCeikTz
	 cB7pP1bY3YnDgw/ICpfyoId6In1Voh0MVJuQokvnE+wPhQVdJmyB8bcDIOahsrWtfR4kz
	 TEYk0cUKH6GvxbP3ZJqrwnmSJpCf46MdoV38OD9DMBqTBuyTmte5L3dmUjb0K2ZehEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b="Lc3/SzPC";
	arc=none smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E63606A335
	for <linux-rt-devel@lists.linux.dev>; Mon, 23 Nov 2026 13:03:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18E63606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Lc3/SzPC
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c50e26763a4so598293466b.1
        for <linux-rt-devel@lists.linux.dev>; Mon, 23 Nov 2026 05:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795438990; x=1796043790; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mDrXuY6jqpxWSzFXHtwGni325RaMm1gVLFRBB2Xcank=;
        b=Lc3/SzPC3+dnrrLlnQnUnJdgjSiCE02JEI56e9hz7eC9jAGTKFJf3u9pbmI7taBqQx
         6BAf9fruNGaRJcTsprEukEMxo0p/jmNbBrmXmaeet7UNdlNbK8LXEUS3P+OtdHZssVR/
         hAC1YCYg18Ezpjv54/twbYlzJqKrjA75S+DfJheIn3IvZaWZxSFRamGJcAcCvOGQMUUS
         zYLcugeRDTWSazuTRMeXHx0bnTLr5fywMwGUUuXlF8NWGEg5JIZ2RtVwB8bY5jPC8Q2c
         ub4y5/1yZyrJMYRRKhY6THNv/k/mZkn/zGlLqPjbrrLDm/Ws8BrqDYq5Uoxxvl1WgRHw
         PZfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795438990; x=1796043790;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mDrXuY6jqpxWSzFXHtwGni325RaMm1gVLFRBB2Xcank=;
        b=npJHFkw86SIGB+LJP8k5hKwGL80qMwkK21jkBBwknJ4yBoegWla62nYuuJY/A3MwVa
         incUFlqHBrxENcAnfprf6kcVb0zhNiiN7FVF/78T0k2b3MiSyw4RztfVb+7HrRZAuaC0
         Lsy3UGfx2oiOLOieXuhYSFHJOFxStKedjoLUJ/zBBBTB+hbyuCplpQZHx5N6cpF2iX+9
         MrZrN25NDvbmYK9ODw/hKLqoAU1WhujUnrABAi5RMYd4vVeOqy68w7nP9s5YBL/Hzj+Z
         Wo3OZIk2MJDivdeSXrLhECDcKtF2WnfRPxbZJs3wRC0s6mbz5tIo9FxAjqyxJeppux/g
         RC/w==
X-Forwarded-Encrypted: i=1; AL+hErE+1Mo97tWnbfFc8dUS+YXkwh1SL7+uAIekWlEhVi2+KhaFj7hu8xeP1A0JaTaZwC1whtLF/TNB5TVa5Dc+aA==@lists.linux.dev
X-Gm-Message-State: APuU4Z8At8LSgbfGwEkhs7bPF/HtXrCofbnGtzhKE578GGu32hCSjLHZ
	wza4ZyoZke8/N7+m0vSql/WoVal5OlVlsn0YSdm/UVXy3aObLzeMK0Lo2x3mxxysJNhcdEkB387
	lC2fZ8eWFKg==
X-Gm-Gg: AZFdTZdiNw5Ln+OihHYmoqAl7Z2XDWI1HWOLpK4eEJz2NiAiBb8BnlyJRuISpoKExFT
	j2U0xTAZGJgYTBXTl3e7o4pevGPjNhhm6FuLE9ZQBEP9njC9+RVBBpNmEpwuFeZSZDwjh/22kqE
	Y+sSwMJK35xL2SCN3QHpeCECZC2iyUHE8kAXUuWWv+UGbiYZSQsws3on2ZyvM9TTorJYgGV6D3e
	h67SBlPPoPwqCQ35Knz7RW39oTizi3FoMbO0anA/ZsJe3QufDWx0pLjFFr8rQ8FPE0dP2Ad6Wa0
	97xZZ7QBkxcT4tx/M/8zmeQ8EuEPiPuHiJ8fX5YVAR0DKPI3JFk43PP3dqF6HLSmmSIKUOUdd2g
	stCn3PmY8sjnji6XeZ4C0qyRo/acUCOEk/y+EmRIIcoQLWq2iEWush0sg72HyjJrVvxpfLo8K8I
	F0ST8ooUhnQCu55el8+KHrT3XFjeolp1+kWNS26Su00d4vk1EKG0ik33GYHlB2YubQF/ox6sY8e
	eNugzmaSh5Zn7EvDmlS7Ww4xktLtd1GCngJ5mMS1yA4KqAHl7izdklriby5ykm8umRMkGRtlSpt
	dypsctvmfKw9OlPPoT277PREP22naeISQ6JI6HtjBvwtNDyJusjMQHf4EiOiLAmO09c7M14Ta6c
	9Orrb58NEqOQXp3mSx1KPxUbrrlHOZYya7io7oXg=
X-Received: by 2002:a17:907:948a:b0:c49:9383:a28 with SMTP id a640c23a62f3a-c513ab42e45mr946851266b.35.1795438990465;
        Mon, 23 Nov 2026 05:03:10 -0800 (PST)
Received: from puffmais2.c.googlers.com (226.124.90.34.bc.googleusercontent.com. [34.90.124.226])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afe85ecsm401379466b.70.2026.11.23.05.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 05:03:09 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Mon, 23 Nov 2026 13:03:07 +0000
Subject: [PATCH 2/2] usb: typec: tcpm/tcpci_maxim: init wakeup before irq
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
Message-Id: <20261123-max77759-wait-v1-2-6fa54a751bb7@linaro.org>
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
2.56.1.750.gf70dc682cf-goog

