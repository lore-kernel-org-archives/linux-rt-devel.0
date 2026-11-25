Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795609032;
	b=E6iFG9O8y5oZ8xHgWERZQgs/7Vwse7F8pTMoXmj0S63d+rbCNEdYy4cqhZN9FqmmGhGj
	 d1vv+fZSQllYZVM5PLqW4XkyGNp4uYGlQrxPyTmc6XTRXDaswvDbwX+u2zwL+6ekZ/wCB
	 HjuFHkrlyJjXU1cEcIhJye/aGdNrmE/nmWJUhlKbgIud3YckA9R9xtWMy9Kc46/ZqX2rD
	 gxnnDUXVZEARggVOdjLgz0cXSmLvZTfpnLOwAatqOFw28OmHF7io8ZYcMI49kJxQB5mcT
	 s1BBaD49oK1Qhzg/lxImhm8Q1dNiTMNu5Elo7hK7rlTdPZE5cx4Mo2yZ6JyYzE0EryQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795609032;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=gUBulya+f6ud4/UzPh4bijl+YYBXVX1Rb5gaE8nRFNM=;
	b=boCgNN+bs53gt8g2ZcS7GosNQh92ld1p3ls03LjAa4Ea/FVBjBLuHQuKUJzMD/j+Czwf
	 v1Ap0Kiv0uF+QWzEt8giurpgba57ZXEfVC+UWJ6X1iPIrCwr9DHqDeitxpD/VyU+KsGl5
	 pnBgNW8x9kcFGBSJmM53Opx8sfzMoI1NgpMlneN0F/G/6GkstjrtCtUDPV5uygT/DX+Pd
	 VLRFNdIbowy9TSmwJvRfMqiBQ2oNK6eQ2fAsxGC3gA9Qq5N8P2TiCKLbOwzEkPaTacQLJ
	 vJV6V7FHZIPbfbfbuo+p0u3WIvgH4ycBNKEjUjm6yK01yjnjE9aXUasInJrsabPZVMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Zjv2nMGT;
	arc=none smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8DF606A334
	for <linux-rt-devel@lists.linux.dev>; Wed, 25 Nov 2026 12:17:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD8DF606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Zjv2nMGT
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c5198302d38so255586366b.0
        for <linux-rt-devel@lists.linux.dev>; Wed, 25 Nov 2026 04:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795609030; x=1796213830; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gUBulya+f6ud4/UzPh4bijl+YYBXVX1Rb5gaE8nRFNM=;
        b=Zjv2nMGTGIlK00BklBZNPar2jkvbz9Glrr7a5BZ7Z+NKGwK84aTTQYYoOWr9eqa6Qp
         riecApHcSwTWEkezwIzdukhZ697E6DFYUCl4lwOT3SdSAG4ZuellHly6T/hnAYjCtwP1
         p6ODfwjsPGjln3D/z6KSv/+goADeFUWWshNm+K88D+v/gh8iP8pPYHQepj3F6FD8BvtJ
         gitwcN9oCiKASvphRO2k+AaawE+UReRy7BXB0uewEV+kSAySSG/gZgl9tj3pO2HPxgj/
         zhdFWvrz5tJbrLSDLtauXr5Aj0YoLxm+JEh5Xz0HpypObEzM957ULgL3+FLcSbPAFxkM
         jweQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795609030; x=1796213830;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gUBulya+f6ud4/UzPh4bijl+YYBXVX1Rb5gaE8nRFNM=;
        b=0/3yx5Y0eb4vnxxXsxBwh0/0DH4EHyrZD9wWGbUCL0QooWCcpTv65JIv5UPuXFooxo
         JKrZsnGA/ZkdeNbOeI/duU6DdOWgXA1yQgTmUmku8/SC8dsTUz0QQsS0oYoGIJw0MlAZ
         ItIyP7LfnzeSP6YrbqzF27AKzPKLc3cl2V9sZyTA0PsAshIxUqXbGP2qRRyF16IQKtSy
         /Qi1k3iJrKF0n6uaiZhVcXYK2j75oSnFW5WjL367fIPQ2Ru7kPXQTAnfAsYH5EFdFG01
         dB5QqMssKtV+sZ4NX+NG3dSShwS7mqFY0mrEbgvFoMG0JSqPDi8oCwDzTUfScRwadZy9
         aagA==
X-Forwarded-Encrypted: i=1; AL+hErH9bzvyC9iQBKmx8xnv0OIhsbkfT5UL1qDP6xuCfmgeiu081ZfRluDGFpNT3IEaUQAQgk8JGMh1/h5ArsEMKQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z/pvjLHsL194SWYo9PiLcXIxPGYvyMmk3dfrM3lYSM6MQAngt4e
	EHaDOlruVPKtZrkmsO5HIzZVdfzlKHjcU4EKqf28lSQIROzhn189OM2jKQ11YlmKrM0=
X-Gm-Gg: AZFdTZfWLqj7VFhYuOE8pMifJdN5JGve+Skv8ImSWPZWWISLcF4rD4gp/jusu+CH8Az
	MLhg4XH92QRuHmIMwLnyGZPmog3WFc/1j/WhfIhJCQPZrxjbDpijGVac6fwDqWcrJYnqpxnJqZj
	JIyZqvcTtqsU3aLhfJt/9g0UI9z5GWU2GzLYfbP/DJhBamYDXVNseWwzgb2+SbnF/i/50uIxw17
	Ga1qIgMzUKPLpGXyFNh0gsI1FDjKblZJBu/UVxwvO1xJ6IKot03wvWpgjZCLRPOn2BkwFmWmE/T
	sOAdso/a3EykElKvqYayNdC27C4dnWjlooRD1y5zcYj0LH7y4nuZmYLAc4c3qVsnwjw/B6cCs7k
	K0kmvJwkxP9oMfd6JSy1WAllk0+94ztKo2nPfE77YkhmQIqrdAG+cJ3NZdqBvshSPzrGnwgOG2t
	p7anTNOQoAw/DNQql/OZb34SMt/lPiCAkxbHCikmbQ/zl2HPed3PXqfcnU5NhdcGS+4rxlPZ9xW
	560c3ODf7KARKKHG1RUNPXaEP2qkWwc5ipPW4vgzNlKzJpWYAKoZBTbWamavTHZm+3Eld4mFQu8
	BfotiG6vsxDtsTd937myTU157OIawyDhyDcMkaHFMk/0o2keYC8SyRs2Sv5ADYO5YtSUi7cyLS/
	XKHKVkxpN4CNxcSPoHg==
X-Received: by 2002:a17:906:3588:b0:c41:6de7:7dee with SMTP id a640c23a62f3a-c513a3ab1a7mr1070767966b.7.1795609030236;
        Wed, 25 Nov 2026 04:17:10 -0800 (PST)
Received: from puffmais2.c.googlers.com (226.124.90.34.bc.googleusercontent.com. [34.90.124.226])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513ad00d2asm650611966b.3.2026.11.25.04.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 04:17:09 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Wed, 25 Nov 2026 12:16:58 +0000
Subject: [PATCH v2 4/4] usb: typec: tcpm/tcpci_maxim: only complain about
 vbus when sourcing
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
Message-Id: <20261125-max77759-wait-v2-4-9914b985c00b@linaro.org>
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
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.3

get_vbus_regulator_handle() logs a spurious "Failed to get vbus
regulator handle" error during probe and stores the ERR_PTR in
chip->vbus_reg even when sourcing VBUS is not requested.

During tcpci_register_port(), tcpm_init_vbus() calls set_vbus(false,
false) before the PMIC charger providing the vbus regulator has probed
(the charger's power supply waits for the TCPM power supply), or on
sink-only boards without a vbus regulator. Sink-only operation does not
need the vbus regulator, and max_tcpci_set_vbus() already ignores
regulator lookup failures when source is false.

Leave chip->vbus_reg untouched when regulator_get_exclusive() fails,
return the error from get_vbus_regulator_handle() silently, and log an
error in max_tcpci_set_vbus() only when sourcing is requested.

Fixes: 0c8935642cb0 ("usb: typec: tcpm/tcpci_maxim: deprecate WAR for setting charger mode")
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/usb/typec/tcpm/tcpci_maxim_core.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpci_maxim_core.c b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
index 2e6a8906fb32..736d01694745 100644
--- a/drivers/usb/typec/tcpm/tcpci_maxim_core.c
+++ b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
@@ -208,15 +208,16 @@ static void process_rx(struct max_tcpci_chip *chip, u16 status)
 
 static int get_vbus_regulator_handle(struct max_tcpci_chip *chip)
 {
-	if (IS_ERR_OR_NULL(chip->vbus_reg)) {
-		chip->vbus_reg = regulator_get_exclusive(chip->dev, "vbus");
-		if (IS_ERR_OR_NULL(chip->vbus_reg)) {
-			dev_err(chip->dev,
-				"Failed to get vbus regulator handle\n");
-			return -ENODEV;
-		}
-	}
+	struct regulator *reg;
+
+	if (chip->vbus_reg)
+		return 0;
 
+	reg = regulator_get_exclusive(chip->dev, "vbus");
+	if (IS_ERR(reg))
+		return PTR_ERR(reg);
+
+	chip->vbus_reg = reg;
 	return 0;
 }
 
@@ -224,7 +225,7 @@ static void max_tcpci_put_vbus_regulator(void *data)
 {
 	struct max_tcpci_chip *chip = data;
 
-	if (!IS_ERR_OR_NULL(chip->vbus_reg))
+	if (chip->vbus_reg)
 		regulator_put(chip->vbus_reg);
 }
 
@@ -244,7 +245,12 @@ static int max_tcpci_set_vbus(struct tcpci *tcpci, struct tcpci_data *tdata, boo
 		 * Regulator is not necessary for sink only applications. Return
 		 * success in cases where sink mode is being modified.
 		 */
-		return source ? ret : 1;
+		if (!source)
+			return 1;
+
+		dev_err(chip->dev, "Failed to get vbus regulator: %pe\n",
+			ERR_PTR(ret));
+		return ret;
 	}
 
 	if (source) {

-- 
2.56.1.831.g720f3f5937-goog

