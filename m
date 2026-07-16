Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F61349CDD
	for <linux-rt-devel@lists.linux.dev>; Thu, 16 Jul 2026 19:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784231845; cv=none; b=BDcRS3uZdyYTuT0Jncomi5thIa19XKZ/x0eEMBuUjbl6bQMI9dpNgz5gqf8mmlxzpTnyT0gwgYNTta2rNozWQHHL7MyQxiaCBQRT6ccBYRdKnHOtxuJQDAcZOSownZVcGqqh6v76RtEJG8lJ+Sr4L7NOfy8cAVBTkSgPDnM5X9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784231845; c=relaxed/simple;
	bh=2sURr9Jhcs/BtUP+ZCw/O2aqjcyTRvA3oykEObBneWs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oJQQLssAQWkqXeYXCtq5fURKPJmZuQcSk5w/svS++dejqub1yaeB2iu03uBEzLxizAxY+NFOuX5oBYU36+MCS4WCiYXd+Ca2qYp13LNLjkVDbbqL/0imBlJRl9mFo6+y70ciewU/UCLVSqUh/z2LSbXCwQtWaaCTzhfFMKnBtYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fiBP6roq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=onWVPdDg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fiBP6roq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="onWVPdDg"
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784231838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7y3LqNGlYi107HI7DGn40B7INXlzsRd7ItKT7wfzMWg=;
	b=fiBP6roq0/b/QCAiV1xEdP9ij2pbTy0DyLkUSLkDtZ40BnbXq+G5Bo1JQ5YbsfRHVGe6ac
	MyLdZP8saIZ9DiiPFwr5v/82509pkH+iBycp+8kvX6TavITyib5zKAni1ZEHhqB7P9KvRK
	uUK/kVGC2l7ldjy/rTnZsTuCJ42gDAl4oW2nBxnEn0/OVpZeofvETA1K+rdmtY+PG382vu
	RB8Jx1WDOG8nKoIBBMlR9fOrqnstE+m80NnWv+Il6CV9aiVhSj8+WmgXuGftDoDdqVNz8x
	vc3qW9Sf7DQ18mWyQrHJl0bPJXhhH6oqDhVHN0Dzq66+8cVvngv8Nce3SgL8EQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784231838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7y3LqNGlYi107HI7DGn40B7INXlzsRd7ItKT7wfzMWg=;
	b=onWVPdDgxaZiktI7kFOCPXc5E+tep9FdW+tP5RvGTkrODU7B/KozFkFAlsiNZXXuXh+Fz7
	IG1X9M0MkJzMQFBg==
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
Subject: [PATCH v4 0/1] Documentation: Add real-time kernel configuration guide
Date: Thu, 16 Jul 2026 21:57:13 +0200
Message-ID: <20260716195716.256025-1-darwi@linutronix.de>
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

Changelog v4
------------

Handle Sashiko review: Remove a no-longer-referenced link.  Remove
CONFIG_WQ_SYS reference, which I thought it exists due to a quick
misunderstanding of core-api/workqueue.

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
 .../real-time/kernel-configuration.rst        | 310 ++++++++++++++++++
 2 files changed, 311 insertions(+)
 create mode 100644 Documentation/core-api/real-time/kernel-configuration.rst

base-commit: a13c140cc289c0b7b3770bce5b3ad42ab35074aa
-- 
2.54.0

