Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DDC344DA8
	for <linux-rt-devel@lists.linux.dev>; Fri, 23 Jan 2026 11:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769168242; cv=none; b=KKy+nLI/SW4xCFEXTv9TX27cvlX6xe1gwNkUSXLueZYEDPaq+ghj3nwgquqznBhwTno8dPGRdPbx8V788/CIvGaK20GqkT7IMxU9K5ltI1M0GWbyfT7FI63d0krS4PvE9VoqwkioLl00oBzHmcuajrf28qHzPx91Rr1E4olLqfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769168242; c=relaxed/simple;
	bh=PDm01bYH0f1j2djPipiypaC3BgwBvxUZlgxTtUxWqTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pFNRWQfR/rLPX8WL5WoGuxI6PXUb7QqgNx5XuPlR9efUYz3mChGRKFYjbx+w6yxLREBJ8/Yh+o0VVnb/Ou+rq0fLJfuoteBjJvsYL8gdiziegh5E9A+sgsVFeGvx00blQ+sa/S7QSJn4ixIz9bqB5fqrS69gFyoPSDr82nhGk9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pxyTdVBQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b3KhJVod; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pxyTdVBQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b3KhJVod"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769168236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0ClL8eAZdmuNbLusg5jOxF2eIGZ+kWzlW9HMsa2ckZU=;
	b=pxyTdVBQ8iNBWKLo47O3PiDCbrqnj6d/vA5AtrI7kRBHJ2n1D0ZVdaRtDJ74Dpq8QHaDM6
	dt9gPz9AdR0TYfQkG+ri9oEFTfuUEYFeF4tAFIagXWObcsVcsPqPjbSauwIWa4KSPexIay
	hVmXRv/N4WVTHn4CxILhrLgKab3vou3+nr08bNgVx6ypqPG9zMz5xxdI1CQpb9b3rAV78w
	iNlcIBGglqlLlQC8rZ5wmVkoJnGjgAxmQDgiyQsAGbKFxykxU5gSXYbAhytltwzkdLJKSw
	GCwKXxbMT0oAiMCLhw2MExOu9GqlA8cOkvDqmhpxIS/cEIvmBeY7dQLR/YofKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769168236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0ClL8eAZdmuNbLusg5jOxF2eIGZ+kWzlW9HMsa2ckZU=;
	b=b3KhJVodDLUW0D4Ju/ixICFDI3BkVvr6KzwD8FRjZSMmF43nHEMJI0S/4/xiJjK/FW9Ugx
	VIPgsPFClpxm1uBA==
To: linux-kernel@vger.kernel.org
Cc: linux-rt-devel@lists.linux.dev,
	Thomas Gleixner <tglx@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Yixun Lan <dlan@gentoo.org>,
	linux-i2c@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH 11/21] i2c: spacemit: Remove IRQF_ONESHOT
Date: Fri, 23 Jan 2026 12:36:57 +0100
Message-ID: <20260123113708.416727-12-bigeasy@linutronix.de>
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

Cc: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Andi Shyti <andi.shyti@kernel.org>
Cc: Yixun Lan <dlan@gentoo.org>
Cc: linux-i2c@vger.kernel.org
Cc: linux-riscv@lists.infradead.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/i2c/busses/i2c-k1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-k1.c b/drivers/i2c/busses/i2c-k1.c
index d42c03ef5db59..8ef6d5d1927b7 100644
--- a/drivers/i2c/busses/i2c-k1.c
+++ b/drivers/i2c/busses/i2c-k1.c
@@ -566,7 +566,7 @@ static int spacemit_i2c_probe(struct platform_device *p=
dev)
 		return dev_err_probe(dev, i2c->irq, "failed to get irq resource");
=20
 	ret =3D devm_request_irq(i2c->dev, i2c->irq, spacemit_i2c_irq_handler,
-			       IRQF_NO_SUSPEND | IRQF_ONESHOT, dev_name(i2c->dev), i2c);
+			       IRQF_NO_SUSPEND, dev_name(i2c->dev), i2c);
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to request irq");
=20
--=20
2.51.0

