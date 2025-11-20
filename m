Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82E33002A8
	for <linux-rt-devel@lists.linux.dev>; Thu, 20 Nov 2025 11:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763638636; cv=none; b=NkshQSob+pVU9sehLNtFKEdOy0QfepBWEJte0ursDdGULwXJ58qJ+PHRKWGKWvc3SW/fEHY/Z+h1GOGa61VEZLk92uwLpvGwWe3yZsFnWHhdzQOmqDEdToavnjznFjSvRCGkM6nlEge9DykPcJGE9Jf178AjjVr/btBZoXb2dW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763638636; c=relaxed/simple;
	bh=K/EVnkdRwdFApDd8v3uR33pUgHgktexI2GhyGhpnKYM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cAGhqZs0B/DI60lYzITig4Sdwi9naX+Fg/gLJgm5YKZg+NEu0/LluvEF2Js6W2SXht8CFLCTCPn1i7Ln9LWf0ZKpM0eC/BCaTzM7Px+gjXtUsrxEG/cEILaedLIBOVv4+ORvCMEkg3N4VJbRadsokO3Ycig2ZUMDDlF8MEBuBto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NT0bBN+k; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8w4DLPDa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NT0bBN+k";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8w4DLPDa"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763638633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Yzf+ZcC/90WbFfPGW7ZXdVC4JWwawLj0A5twWRn8DK0=;
	b=NT0bBN+kvJEgnhT/LQCjKe2hQlrFL9L5LweiAQMiHCE5Wrt/ThTA7WiNEQSRiyPmoNUsgo
	+wZ7yggXc2vkMSCLpJzItV3bdH7YcpughBgY0KWjl+qj4I/jYQikhkrsz2Raqhilg5/Cfp
	MKGPPFoJ6S0URE7+6e2Bf5JZ0E9P0/c57lqMf8agQDi/Ude8VRMtGo/ju5Gc7lx2Rf/xFM
	4qo+G+VCTG6HL1rf50b/aotsJlUr8/YY46Q19FykfLgKHtUI2x4dANq7EkHoidfVEM5Ssj
	0wMndh9twvnRATwdWhGhMVG0PGjvsu/eRW2TNSjy92Tn9DtO8cQE2oDpO+e5Qw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763638633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Yzf+ZcC/90WbFfPGW7ZXdVC4JWwawLj0A5twWRn8DK0=;
	b=8w4DLPDaVIX9nydEJE7UlqnZ9+vobc9KVa5ETJen2u6CBG76RqO6CD4iiUHEamWTc061dC
	ues9KtlYpNKhU8Bg==
To: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: Clark Williams <clrkwllms@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 0/3] Documentation: Update the real-time documentation
Date: Thu, 20 Nov 2025 12:37:05 +0100
Message-ID: <20251120113708.83671-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This series adds an overview over hardware. It does not explain every
tiny bit but explains for instance why power management or USB might be
a bad thing.

I also collected Lukas' patches which rename a referenced Kconfig symbol
and a maintainers entry for the docs.

Lukas Bulwahn (2):
  Documentation: update config name in real-time architecture support
  MAINTAINERS: Add doc files on real-time support to Real-time Linux

Sebastian Andrzej Siewior (1):
  Documentation: Add some hardware hints for real-time

 .../real-time/architecture-porting.rst        |   3 +-
 Documentation/core-api/real-time/hardware.rst | 132 ++++++++++++++++++
 Documentation/core-api/real-time/index.rst    |   1 +
 MAINTAINERS                                   |   1 +
 4 files changed, 136 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/core-api/real-time/hardware.rst

--=20
2.51.0

