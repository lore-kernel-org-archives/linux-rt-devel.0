Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA08B3542E9
	for <linux-rt-devel@lists.linux.dev>; Fri, 23 Jan 2026 11:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769168246; cv=none; b=NUCjUqwV2yNUcB+NJtyJ0EvKnaCTBaKYMfRvuY8jAmslYO5iNC0fNZiP8/i3LaXECNLJb7NYl99iOUOkgTws56jCCil8iXlOwk7h/VclTKd/zqofRN2xXg3pb3aiT+ObkUXO1eXDTBnAkRv8SGOVYC4A9xR+Nw3ipOCSHUNQeJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769168246; c=relaxed/simple;
	bh=yvzDIWWhEANEW4PbM7NkDFVfHEP4kbyT4pI78b1eorY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fQiOz0+LH/jw6CHyB9ZnLsvUBIQqHKpeKoO5FK+YISlcn2ejOPS4CZ7j5pBC3IyvAEUiSt6QnHmq9Tg8zfaq0OiudpvIJ14UZBkplt/fGwwqSnwslSWK4KGgTjttThBC8Vq35GWRa/ljdIX/MUPsrhoLyV02r7YEFlRZhsTM/00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uNZGBqF2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dkAtlJcA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uNZGBqF2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dkAtlJcA"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769168241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j0rNXMOI7j3rGJB/+4/ynkZTe41c0CB08LUfoR/1ch8=;
	b=uNZGBqF2HBQ4IjF5XXI4RozcvOK0eDbvgtmfG3q71PLU6NCUkKEFNjV8fZeR8a2qh48Yqm
	Ie1qPqfVpsX4Bzrc5tSyeendqZ+wX/WNbfLfSYYNBBRqGyHlc6ZF4X3NUwz67joHp9fWnw
	W/1YqLxQfVzOx/VINgiFFmJqa/vJEi296otWYOVvFYI3DxlBnO/S+bOWlAXDvkBMKiuAb9
	vuTdLx9BNZPVwtaU9PG6DhDeRAJ6UgcGHPdtf2iZOKBMkw0xtMVUAZoNheQdMTiY1fQIOe
	sUAZc9vBp5+kUeeP79j9jUeGLP0IySpLzlhzdala4dONB5ckgT/SLQgOxx2wkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769168241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j0rNXMOI7j3rGJB/+4/ynkZTe41c0CB08LUfoR/1ch8=;
	b=dkAtlJcA7fdbuGNJCEXB5q7Mg1SR+dw/uCacVMHfsWwoydSrUM9TZgaDLaMNF3c4rMzVbJ
	FMLVSwbz7y0a9zDg==
To: linux-kernel@vger.kernel.org
Cc: linux-rt-devel@lists.linux.dev,
	Thomas Gleixner <tglx@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Martin Tuma <martin.tuma@digiteqautomotive.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org
Subject: [PATCH 21/21] media: pci: mg4b: Use IRQF_NO_THREAD
Date: Fri, 23 Jan 2026 12:37:07 +0100
Message-ID: <20260123113708.416727-22-bigeasy@linutronix.de>
In-Reply-To: <20260123113708.416727-1-bigeasy@linutronix.de>
References: <20260123113708.416727-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The interrupt handler iio_trigger_generic_data_rdy_poll() will invoke
other interrupt handler and this supposed to happen from within the
hardirq.

Use IRQF_NO_THREAD to forbid forced-threading.

Cc: Martin Tuma <martin.tuma@digiteqautomotive.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org
Fixes: 0ab13674a9bd1 ("media: pci: mgb4: Added Digiteq Automotive MGB4 driv=
er")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/media/pci/mgb4/mgb4_trigger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/mgb4/mgb4_trigger.c b/drivers/media/pci/mgb4=
/mgb4_trigger.c
index 4f9a35904b418..70cad324df608 100644
--- a/drivers/media/pci/mgb4/mgb4_trigger.c
+++ b/drivers/media/pci/mgb4/mgb4_trigger.c
@@ -115,7 +115,7 @@ static int probe_trigger(struct iio_dev *indio_dev, int=
 irq)
 	if (!st->trig)
 		return -ENOMEM;
=20
-	ret =3D request_irq(irq, &iio_trigger_generic_data_rdy_poll, 0,
+	ret =3D request_irq(irq, &iio_trigger_generic_data_rdy_poll, IRQF_NO_THRE=
AD,
 			  "mgb4-trigger", st->trig);
 	if (ret)
 		goto error_free_trig;
--=20
2.51.0

