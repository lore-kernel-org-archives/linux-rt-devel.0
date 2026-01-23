Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB4232E143
	for <linux-rt-devel@lists.linux.dev>; Fri, 23 Jan 2026 11:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769168243; cv=none; b=lvX19o5wq5mBt2n9LfgK5qU+cvZTqaC2Dn8mRHkLA4r+Lbx36X6RzZNLwFHZK4JCt98qZhSywefGeVljSUx+ddpL84ebJGnsMoiyR5kZo3bSwkG7LibhXlsDnWOKO3Usc9uldImK4caAcwAWpm5qsvgXiBhES4TMxTCN8eENJeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769168243; c=relaxed/simple;
	bh=cLKLW6ziX3Ksgnw3BL6kHmpaf7kAWOi/CXF1JlHLr4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mwvR1Lgms3lNTX9qGgZxQ5h/TWG3eOBc4pDogVYJa3Iw+ieqbHY5I9B9LqMHdzboyVah40MZf6T8lFuc2InmVtizfQXAckIvLl9Qq6h7knJ5ofDXHfv8UWttTZhB1kPIfTfYEESwj37VoUX4tYRHrJ1axFQATznfVibv0e+vRg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1PpWPZTu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ujN/GR4s; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1PpWPZTu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ujN/GR4s"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769168238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OWR1GspezhW/fA+bl2hg34AmkML9jjEGl3PypfM+23g=;
	b=1PpWPZTuYYTnGYpI26iiIFHfDG8tkeSIwOcJ9P5M18sGm4PDcMMt6hUrri9jaHtlkJOMVm
	L2gBkBdGepU7UuMIFLdOf6wSsAXMedQroV1jMDlm62XkaSpl3r2OmHIKzdTdjc3iQN2P18
	sQ4DVfvN7HTQ7VPW7Bk0/C31QoBIj5PTlmTwgNHbGMd5+dwIQHvyVqNpUvzVGUyMOPtWfX
	+Qos0dID5gk4Jp8w1GLI8sSf8EIdsjJQia65QwAfv9C8Pa6k/YuNKH4iUUdUjLavmweTMT
	XVf7Fci7xrj/01Z3d7Sq4uwP2ZvkOfs3ueIeMzSX0mnHkfobOusHCIV+3uXp3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769168238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OWR1GspezhW/fA+bl2hg34AmkML9jjEGl3PypfM+23g=;
	b=ujN/GR4s0WsDQLcEcwTJ3J37tkYddDQzVvcOAenhPvB5hxcogC4rxEd0KVD7jr0wNnxqtg
	lBfpKZMK0w/nKOCQ==
To: linux-kernel@vger.kernel.org
Cc: linux-rt-devel@lists.linux.dev,
	Thomas Gleixner <tglx@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Oder Chiou <oder_chiou@realtek.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org
Subject: [PATCH 12/21] ASoC: codecs: rt56*: Remove IRQF_ONESHOT
Date: Fri, 23 Jan 2026 12:36:58 +0100
Message-ID: <20260123113708.416727-13-bigeasy@linutronix.de>
In-Reply-To: <20260123113708.416727-1-bigeasy@linutronix.de>
References: <20260123113708.416727-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Passing IRQF_ONESHOT ensures that the interrupt source is masked until
the secondary (threaded) handler is done. If only a primary handler is
used then the flag makes no sense because the interrupt can not fire
(again) while its handler is running.
The flag also disallows force-threading of the primary handler and the
irq-core will warn about this.

Remove IRQF_ONESHOT from irqflags.

Cc: Oder Chiou <oder_chiou@realtek.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 sound/soc/codecs/rt5640.c | 4 ++--
 sound/soc/codecs/rt5651.c | 2 +-
 sound/soc/codecs/rt5663.c | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index 4c08c274f50e2..db2222e6f2e75 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -2564,7 +2564,7 @@ static void rt5640_enable_jack_detect(struct snd_soc_=
component *component,
 		rt5640->use_platform_clock =3D jack_data->use_platform_clock;
=20
 	ret =3D request_irq(rt5640->irq, rt5640_irq,
-			  IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+			  IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
 			  "rt5640", rt5640);
 	if (ret) {
 		dev_warn(component->dev, "Failed to request IRQ %d: %d\n", rt5640->irq, =
ret);
@@ -2618,7 +2618,7 @@ static void rt5640_enable_hda_jack_detect(
 	rt5640->jack =3D jack;
=20
 	ret =3D request_irq(rt5640->irq, rt5640_irq,
-			  IRQF_TRIGGER_RISING | IRQF_ONESHOT, "rt5640", rt5640);
+			  IRQF_TRIGGER_RISING, "rt5640", rt5640);
 	if (ret) {
 		dev_warn(component->dev, "Failed to request IRQ %d: %d\n", rt5640->irq, =
ret);
 		rt5640->jack =3D NULL;
diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index 9af65a38f0ee6..23c4bf3da2982 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -2262,7 +2262,7 @@ static int rt5651_i2c_probe(struct i2c_client *i2c)
=20
 	ret =3D devm_request_irq(&i2c->dev, rt5651->irq, rt5651_irq,
 			       IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING
-			       | IRQF_ONESHOT | IRQF_NO_AUTOEN, "rt5651", rt5651);
+			       | IRQF_NO_AUTOEN, "rt5651", rt5651);
 	if (ret) {
 		dev_warn(&i2c->dev, "Failed to request IRQ %d: %d\n",
 			 rt5651->irq, ret);
diff --git a/sound/soc/codecs/rt5663.c b/sound/soc/codecs/rt5663.c
index e4d8785e64c10..eee1c98cc4aa6 100644
--- a/sound/soc/codecs/rt5663.c
+++ b/sound/soc/codecs/rt5663.c
@@ -3689,8 +3689,8 @@ static int rt5663_i2c_probe(struct i2c_client *i2c)
=20
 	if (i2c->irq) {
 		ret =3D request_irq(i2c->irq, rt5663_irq,
-			IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING
-			| IRQF_ONESHOT, "rt5663", rt5663);
+			IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
+			"rt5663", rt5663);
 		if (ret) {
 			dev_err(&i2c->dev, "%s Failed to request IRQ: %d\n",
 				__func__, ret);
--=20
2.51.0

