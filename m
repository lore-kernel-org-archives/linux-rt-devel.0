Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D1322A4DB
	for <linux-rt-devel@lists.linux.dev>; Thu, 27 Nov 2025 15:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764257820; cv=none; b=E68d4CtypDfaiqWRg4j2roJYUf9ujpHsoilvYRD54fFi+bK0WfKL359pWMqZ+cQI/LML6m5uHCFlGlRs2Cw/MVBk5z9nDkiyfSY25ZOKj9z8XwipjdWDW/4D8HqNpQV4wHg8TB/gLn2aNe4ECRvhkR8yLeQKh2wnfJc3aIti6jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764257820; c=relaxed/simple;
	bh=iThmJCXUhDdzKWWpta1Qt/8p8rCfJ1q2CrXDf05av30=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N4ffN3OQ+fKdSYw+bu5EkTnZAm8LJzJf+im8xRuoJWxt0YAFd0ntbMYTKfB2qpf7vdr9xKHEcWIZhNRJVoWXBiZ99x5V/dtYKMGzIznp2bHokXIM+KtHu9SUXe6m6K5RGVbnVgek57V+vK6jyfSO0ZRtV5BWu0yoJdSmhKu7Kos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sq5sKgqF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1CGB+ePx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sq5sKgqF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1CGB+ePx"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764257817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HrZvFEIFvHJ+igARpQj2a6Ibjkb1F+s3/AioNspfYvM=;
	b=sq5sKgqF2CP1kTQgRwDUwYgEqoqEJBJJo9SIFE+Q6A+rNR2dq9vfk62/ovOTdV8DBsx7nV
	VE+jYjWQuEbad2Pp24wg63DzSr4J23Xjz2oRN3mXBS1q2+NeRHzs8V+GKXlP0oCGm50zFh
	3CLmGLmicnj8xL383o+Z5e3W2nJVBZo2ksxLTZWZFnoR7ezL6+qGh7Y8lUjF03h6ZzeVAz
	NUdql0KRQHPNk62HMXXuiUh3TABpNSj8fH0JZbWP5c4RWBVIIQw/ZBeANOqE8TqZPMI4NJ
	mzIuhgab8WmyCvg6iTRqvI13rANdP8kUGC2aGBk6vALQlSMzMFnXOYlypyqs/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764257817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HrZvFEIFvHJ+igARpQj2a6Ibjkb1F+s3/AioNspfYvM=;
	b=1CGB+ePxi4yGoyAH9eMMFJu5d9SDiDpl93L2ne89EkiRgfGPDVqqQxNSLq6wEptJgb/xaH
	2BgMy73HU0Tl3iBg==
To: linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 0/2] debugobjects: RT related change and noch annotation
Date: Thu, 27 Nov 2025 16:36:50 +0100
Message-ID: <20251127153652.291697-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The first is a repost of
	https://lore.kernel.org/all/20251106120628.AxWa_Viy@linutronix.de/

the second is a fix of the override annotation.

Sebastian Andrzej Siewior (2):
  debugobjects: Allow to refill the pool before SYSTEM_SCHEDULING
  debugobjects: Use LD_WAIT_CONFIG instead of LD_WAIT_SLEEP

 lib/debugobjects.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--=20
2.51.0

