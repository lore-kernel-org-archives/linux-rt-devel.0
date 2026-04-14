Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6E83F0779
	for <linux-rt-devel@lists.linux.dev>; Tue, 14 Apr 2026 17:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776188530; cv=none; b=oB8kxBrRRr7b2sqZExLTD1Vfs+USxudaefmYAZ7wzCXqa3XYpWSLUIPIDWORrdx/ayaFFB2vcdwI7t+1TizbFW90GKIhZhsh0tFjP76X14iJs9BnlEojaiXXbkvrXKCgyn6+G5AWBfKis+dBN9JbB54F+LQMLgwdYi79OFxT6I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776188530; c=relaxed/simple;
	bh=+njpjNYDXr1TLhGgv8LrXVrVWerFCUYHRVHmJY/2l6c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HImtLzOPPibHAlcRJrNN5jnYrjDtayhCNCnz4fzYKd9ylJoQf5gRQmCmyKAOsaAZhdoZ4PeuWX/GKtIRARUgIlspb7Bj+aJSAHWAgigbnZymAXmxYZTVXK3AbC4aQXDlMRhqjB6lAEq4oH0bHq517c7NpVPURMKvdxtHPlevlxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=seaHhH6K; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VjaOllej; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="seaHhH6K";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VjaOllej"
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1776188527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QbUDy2EirPvh89rAfsM6+Zun8ri046OGEA8AG7SMP/I=;
	b=seaHhH6KwwlMBsNCauJiJL41+IL68OJw/81x9rlZF+3EzlEbaC27jJBqbnhd41s8pnpMzB
	JpuRTCcMMFvvqqHvovKhKU5MGktBUZOIW4BdcEqnzAMI72HWGTjfpKpA/A3E3f+I6QSRP9
	Vcz1YtQXHzgpQ3uiZNzvcoCu/cRGt3VJjN9QMHwNajBf07R1OxAe69KCjmW8KvA58Zd84t
	r6dy+8MfRuAI1mZhmNl4VrPp449QuOd2kEXK1mvQkpsWyUFgZrFYiu2mqAhHwPi13HcmSO
	RA1W91JpvBnIVMdYgrIirsN82QZJHh+Z/7r0e/XXuapQNpFMxNBi1P8rj4Zg4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1776188527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QbUDy2EirPvh89rAfsM6+Zun8ri046OGEA8AG7SMP/I=;
	b=VjaOllejE5qYpSmtsyvVpdxkCJQJgWu8wQq/trM+zTMi6GYGqZvIXG0yTIm333yy9WVNoX
	3SBp3Pwxcn4UdFAA==
To: Jonathan Corbet <corbet@lwn.net>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev
Cc: Matthew Wilcox <willy@infradead.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	Derek Barbosa <debarbos@redhat.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v2 0/1] Documentation: Add real-time kernel configuration guide
Date: Tue, 14 Apr 2026 19:41:55 +0200
Message-ID: <20260414174159.1271171-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

There is a no "one size fits all" solution for configuring a PREEMPT_RT
kernel.  Intorduce a PREEMPT_RT kernel configuration guide to better help
system developers and integrators.

Changelog v2
------------

Handle Rostedt remarks:

- Better reword certain paragraphs and statements
- Warn about enabling CONFIG_IRQSOFF_TRACER and CONFIG_PREEMPT_TRACER

Handle Wilcox remarks:

- Remove ToC comment + minor rewording

Changelog v1
------------

https://lore.kernel.org/lkml/20260305205023.361530-1-darwi@linutronix.de

Thanks,

8<-----

 Documentation/core-api/real-time/index.rst    |   1 +
 .../real-time/kernel-configuration.rst        | 313 ++++++++++++++++++
 2 files changed, 314 insertions(+)
 create mode 100644 Documentation/core-api/real-time/kernel-configuration.rst

base-commit: 028ef9c96e96197026887c0f092424679298aae8
-- 
2.53.0

