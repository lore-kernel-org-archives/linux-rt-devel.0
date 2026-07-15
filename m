Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C8D3815E7
	for <linux-rt-devel@lists.linux.dev>; Wed, 15 Jul 2026 15:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784127714; cv=none; b=PXUN1wG1eqkCUZjrK9jENVUxDJLlWYe5m8dnygB+2a3DNr5UCjjXQXE3nGu0bEghn5ARGXQ3KhsKZ1eCUj+KzOtAt8BdOYL+0CoDpMwWc1ir/6O4y3u72TaxZqhpoYb1TAjCYH2KgqqRsVqsZTl44Mz8gcz2z2eifAw8FnBVF4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784127714; c=relaxed/simple;
	bh=k1kqoJ3qig2IBgFwaMuCKFR8cC5FtbwhvKHacSYYEgI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ETw+4hLPIGY4zGvy/Yr5eGE1ja8k4jHvRI4Is5Seu7f1PReMPtrEbpH3ofcQucllMcIkZBpOhE79oKSaFntqmoG/D7xwl4H+48vf433UIaVVufDve9T5+z3CQDbJ4JsuiKyou85NZ4lQVATBnMVKXPMCbqfGrckKKp4rBA77agE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I7ZVS+pk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TimlBIcu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I7ZVS+pk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TimlBIcu"
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784127712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mRaHrK9A59TB9ieo0GwP65DcSFK32X8hnB3vC0Accqk=;
	b=I7ZVS+pkbP2DGf5WPnYuKQB6L/u6Uk62Mx3UnOOVKOAJpZ8wqwvfhbOV7EKEI57Kgy3F0U
	QA2jagwaBk4a/VUasz9UGjS/dGFIFlADp64uVjcFA/ksZy/T0+Xaw2KroS3xUT5zfuL9s+
	o5Gyf5/gf65ev9zg3tbZBfsDggh2uel5TWR4R/JkSdj9Y7aavg+DwXxTUmTU7Nyt0wKTUi
	kZvyTjdZLufvkt121AuhD8lnbiOa7N58MvYY/L9G5JlGLwQJbCimSF7xvg9XbBBOjPpaF7
	SuV6QbPHTqMdPKp/Oy5cZhiy76RyczR8LsoKq3wo+adXBQK+pf1kvsC87Iwv4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784127712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mRaHrK9A59TB9ieo0GwP65DcSFK32X8hnB3vC0Accqk=;
	b=TimlBIcuoTjTOmxMpvAwavrwwxywtkx9nEIGjArwEqko6/Knze1W5anqVGuvK0tjfxeVdU
	F7usCJVytCVpuDCQ==
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
Subject: [PATCH v3 0/1] Documentation: Add real-time kernel configuration guide
Date: Wed, 15 Jul 2026 17:01:45 +0200
Message-ID: <20260715150147.225715-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

There is a no "one size fits all" solution for configuring a PREEMPT_RT
kernel.

Intorduce a PREEMPT_RT kernel configuration guide to better help system
developers and integrators.

Changelog v3
------------

CONFIG_EFI_DISABLE_RUNTIME: Mention that system integrators can now assign
the efi_runtime workqueue CPU affinity, then safely pin RT tasks on a
different CPU range.

Changelog v2
------------

https://msgid.link/20260414174159.1271171-1-darwi@linutronix.de

Handle Rostedt remarks:

- Better reword certain paragraphs and statements
- Warn about enabling CONFIG_IRQSOFF_TRACER and CONFIG_PREEMPT_TRACER

Handle Wilcox remarks:

- Remove ToC comment + minor rewording

Changelog v1
------------

https://msgid.link/20260305205023.361530-1-darwi@linutronix.de

Thanks,

8<-----

Ahmed S. Darwish (1):
  Documentation: real-time: Add kernel configuration guide

 Documentation/core-api/real-time/index.rst    |   1 +
 .../real-time/kernel-configuration.rst        | 313 ++++++++++++++++++
 2 files changed, 314 insertions(+)
 create mode 100644 Documentation/core-api/real-time/kernel-configuration.rst

base-commit: a13c140cc289c0b7b3770bce5b3ad42ab35074aa
-- 
2.54.0

