Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795609031;
	b=I0jGIZ9p7hqxkHausbQVQ1mWDT2NNMbWmxLgtnQ5nvtX31CSzRh8ky+qBvPRCQi+ujpN
	 NJhL4isaCm/pEd+TkBeq1Z84BdeG1Inms9qPDD6OXEnkqeuLZvhwY5NdkbscWR6PuX2Wy
	 yBN9AMiIGfIyzhHE2QbHC6HLvPIkHbxa/dFNcvPi/TGT5iXztlLIuT42YWL9WVUvvSPt2
	 xhfxWJRrOqQfcegrkeWLhHW0tyNxDvyrZ2Q3OwxswJjGiZQqIcICu/n7iWbxhILlX7++K
	 QuqqKB+a8X9uL2d8bEFVwPdDNvhbqyNpPOQbDG7lGwJ5nC4m+h40lm7knDJcP/iFoIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795609031;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=ANnF4gP22dTclfpg2OY2BM2KOhGsixC07z+vMijIrP0=;
	b=jj+XNleUZw2h87unGog3uKPcz50FGuodUoWTAkM4Vk+e5Wvwh4KXG9g66Dd2frwqbwVE
	 7DU0yFnnaMiiJV+XtgCKiGAbJdao5D7jeNUwW7WHeOHxWbJHOFnP6do/RgT/pAq+IB+Fl
	 j0KbbrqlKrGwxVK7hu/QEvvt7WiV+uaJDdQTufbxnqPXBl3BbXL3ZO3nbHbvaeV9eX6Dv
	 XcG3Ldjw7a+22+hjTJHUeaML9hVCoFoizV3NbgyqnGBIt6NqW2P5mfi8GiYLVX1VJnFiX
	 pyJ1qwRhLJPnVyZt8kid0roL7qeggOJwoAjMufc4JfOzHD3IGTSedCZzI56mQBU6KNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b="FDM/IrUd";
	arc=none smtp.remote-ip=209.85.218.42
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA3B606A33F
	for <linux-rt-devel@lists.linux.dev>; Wed, 25 Nov 2026 12:17:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3AA3B606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=FDM/IrUd
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c515369b627so578199566b.1
        for <linux-rt-devel@lists.linux.dev>; Wed, 25 Nov 2026 04:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795609030; x=1796213830; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ANnF4gP22dTclfpg2OY2BM2KOhGsixC07z+vMijIrP0=;
        b=FDM/IrUd09vE/hG7Bs8+6WywDeHwhp6PqXqXiLlMAd8VmTpWVGJT9/GD/kMgsmg6gl
         25fgB+ESOhUswu596xxW6L4XLKNR3rbOlT8xXqQquLF7YNL7UPtolp/1bsP1GMCnimcl
         XVvu6JAZcZuTNvU2KxGyPe78GpsokRLUj/QKNQ8gV2y+5N0H9yHYqvehuEBvoJUcUbxv
         bixPr873tH1ptfWofurTtsGca/QarxpMzaa+Y/X1r+EAQ7yfsHBldaIxSmAXw4ZhrKSw
         I1OmaxWCMpGh8YeMDFa17WsZ9cy23ZpiAV6+Df+wTM8JwKHxXOsA3yLGY3UlXqUdrbuf
         6IMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795609030; x=1796213830;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ANnF4gP22dTclfpg2OY2BM2KOhGsixC07z+vMijIrP0=;
        b=MlmrxjgZF3P7J5/KuQWGYC+rbmm9+ZCLDwD4pGMsLioUPNxO/xhC7F0Vm8iHTbY4QD
         Mn9p3WRXHcAny51JJ9P0F2BLZCFCTOOWLNH5GeRQ2UhgXSrZ18vjRnnoeVizJtdEEBq1
         hRjkoGfJ4mj0eU3bj0VtaUC+yOuhLzPyz4dS6fwMa+572e24uzOHXzvn1C4xZ1NPU5wK
         Tz/BeQLVaH+o4MFYiaA9lTzz6xsQoKby8JOo5VBUqAL0k6iBjBb0YtViLa31miL+yHyr
         BSVZZJy2UKrbE90lBOd1f7G7qagOsA0AEUeY9kOUoEb8D1fO7ffTdLzVfzIpMOTZdW14
         J7gw==
X-Forwarded-Encrypted: i=1; AL+hErEdvRGoJL6Zy4DuQPjdDbMq8BrhTO0xZ4nmArowdGYEyc2Zd9TKXUwYj/nPpRne9mfAA4gM6FAy6ULOcUmfLQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z/2qMbBpWY0DlEeJtHjEYvrliRS2JW7n3TV8B7qdqFpeTXSkIUz
	Ha6LAw98nPV1bLlRiml4OGZ51DjHCqUrPYI8nyYqxdy/6sa7el1zlKNOOsYb7H98S6I=
X-Gm-Gg: AZFdTZfAubsRxFDnjK7sHqeBaD5ypyi8yek9NNRPOI5A+qwQA33lzSmvsGl9JxmSEId
	+RDc0otpJOykvjTkGWrMQk53dBz4WNu8+5ouRCKTZqBfca+1C3bvcP8DjxaclOjy1Hv0Bo+szfu
	Rwiz9UJ3JTx+fWeXaXLUtBNmsZB6nAFSvuWCQ46x4RKgqSnmudEDSlDulMsxtr9fHVjS3pqoi78
	ywdjmc6lUdaxuaPYBwFAIcOzQt6ygfvLJ+y6aB0Jm6jD0XDLJxEFTJsIWI5a3269SxKxlzgDMpz
	eg6sZDe4itEcsSafq70tHlc0OdnKOo+sLjFIOokXqnH+UeI+eRRYR35oDU8ecJXSIH8KTTzKyWA
	CV6knkHPrD491smLbzD07zVOSQk7cfP32D60os/RnzXbg637sspSqEU8Xj9zc44pWslUGldG1bi
	8FbZ0DlmDI67Vc45PQyUZpbkR5/cOE1dWAJYsRTKed2kagCJcgDYU9E+hKmLbme78+3nce992rZ
	2Z9ccY404KeAczT2unz2u9pHt3N8n9+vFdw35GQL59hn7vD8kaJXO8nmCIR4w0k+NVIrWGDwaXW
	T5FF22oEOZICAqWyxnJ3tMQIrqiNNqa3tNyL7V368YjJuBkZdy+RsglqBgvbjdJNsY3t3EEhhyc
	dDwZ6pUeBDvSShdePFQ==
X-Received: by 2002:a17:906:f8cf:b0:c50:bf14:8ec1 with SMTP id a640c23a62f3a-c513ab4d93emr1021800466b.33.1795609029664;
        Wed, 25 Nov 2026 04:17:09 -0800 (PST)
Received: from puffmais2.c.googlers.com (226.124.90.34.bc.googleusercontent.com. [34.90.124.226])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513ad00d2asm650611966b.3.2026.11.25.04.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 04:17:09 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Wed, 25 Nov 2026 12:16:57 +0000
Subject: [PATCH v2 3/4] usb: typec: tcpm/tcpci_maxim: fix vbus regulator
 UAF on unbind
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
Message-Id: <20261125-max77759-wait-v2-3-9914b985c00b@linaro.org>
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

Unbinding the tcpci_maxim driver triggers a use-after-free in
regulator_disable() if the driver has acquired the vbus regulator:

    Unable to handle kernel paging request at virtual address
    006b6b6b6b6b6bb7
    pc : regulator_lock_recursive+0x20/0x218
    lr : regulator_lock_dependent+0x198/0x2c0
    Call trace:
     regulator_lock_recursive+0x20/0x218 (P)
     regulator_lock_dependent+0x198/0x2c0
     regulator_disable+0x4c/0x100
     max_tcpci_set_vbus+0x70/0x108 [tcpci_maxim]
     tcpci_set_vbus+0x44/0x100 [tcpci]
     tcpm_reset_port+0x13c/0x288 [tcpm]
     tcpm_unregister_port+0x70/0x120 [tcpm]
     tcpci_unregister_port+0x24/0x68 [tcpci]
     max_tcpci_unregister_tcpci_port+0x18/0x30 [tcpci_maxim]
     devm_action_release+0x1c/0x30

max_tcpci_set_vbus() obtains chip->vbus_reg lazily via
devm_regulator_get_exclusive(). When the regulator is acquired after
max_tcpci_probe() has queued max_tcpci_unregister_tcpci_port() with
devm_add_action_or_reset(), devres releases resources in reverse order
and frees the regulator handle before max_tcpci_unregister_tcpci_port()
unregisters the port and max_tcpci_set_vbus() accesses chip->vbus_reg.

Switch to regulator_get_exclusive() and register a devres cleanup action
for regulator_put() before tcpci_register_port(), so the port is
unregistered and tcpm_reset_port() disables VBUS before the regulator
handle is released.

Fixes: 0c8935642cb0 ("usb: typec: tcpm/tcpci_maxim: deprecate WAR for setting charger mode")
Cc: stable@vger.kernel.org
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/usb/typec/tcpm/tcpci_maxim_core.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpci_maxim_core.c b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
index 2bb306b6b1f9..2e6a8906fb32 100644
--- a/drivers/usb/typec/tcpm/tcpci_maxim_core.c
+++ b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
@@ -209,8 +209,7 @@ static void process_rx(struct max_tcpci_chip *chip, u16 status)
 static int get_vbus_regulator_handle(struct max_tcpci_chip *chip)
 {
 	if (IS_ERR_OR_NULL(chip->vbus_reg)) {
-		chip->vbus_reg = devm_regulator_get_exclusive(chip->dev,
-							      "vbus");
+		chip->vbus_reg = regulator_get_exclusive(chip->dev, "vbus");
 		if (IS_ERR_OR_NULL(chip->vbus_reg)) {
 			dev_err(chip->dev,
 				"Failed to get vbus regulator handle\n");
@@ -221,6 +220,14 @@ static int get_vbus_regulator_handle(struct max_tcpci_chip *chip)
 	return 0;
 }
 
+static void max_tcpci_put_vbus_regulator(void *data)
+{
+	struct max_tcpci_chip *chip = data;
+
+	if (!IS_ERR_OR_NULL(chip->vbus_reg))
+		regulator_put(chip->vbus_reg);
+}
+
 static int max_tcpci_set_vbus(struct tcpci *tcpci, struct tcpci_data *tdata, bool source, bool sink)
 {
 	struct max_tcpci_chip *chip = tdata_to_max_tcpci(tdata);
@@ -514,6 +521,11 @@ static int max_tcpci_probe(struct i2c_client *client)
 	chip->data.cable_comm_capable = true;
 	chip->data.attempt_vconn_swap_discovery = max_tcpci_attempt_vconn_swap_discovery;
 
+	ret = devm_add_action_or_reset(&client->dev,
+				       max_tcpci_put_vbus_regulator, chip);
+	if (ret)
+		return ret;
+
 	max_tcpci_init_regs(chip);
 	chip->tcpci = tcpci_register_port(chip->dev, &chip->data);
 	if (IS_ERR(chip->tcpci))

-- 
2.56.1.831.g720f3f5937-goog

