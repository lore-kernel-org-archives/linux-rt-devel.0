Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A4346C837
	for <linux-rt-devel@lists.linux.dev>; Tue,  4 Aug 2026 14:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785852965; cv=none; b=uw62S5m3p3Ju4WFZvCPfZrE/e3EaoZZ6wHugrFh7NUeIzO0DUSrFbosl5LVWh9Kjqt2Uo9VwRPbTKbz4qmJp7LX2wNjSCVSuDhEhU2zYXndvSuL1AVZDxKly1bSjGgd8HQpYdtqNZsIp8hDO22ep7PNx1HMhGtwFd9Y4GMWInfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785852965; c=relaxed/simple;
	bh=/fTkeSjuggO4bSqTmeDQYBcq8t4gF69jykfkJ8SXRfs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M/q4CCXZdAZamIImnWT8jOrEIUyANOGVFI40fO3XT+RMq45OKPS/1mjndR95C6+GJWbWHbqsI6KH2mGkRsXDK6Mb0w1xB/JH0NO2gq8d4P8CvPCpZU7KLTHIidumXnIlDeAxhi+3cslRy1F/wnwwCX6LVAFTsMwGF5df2xISHjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t6NWS35d; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PjLWKdt3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t6NWS35d";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PjLWKdt3"
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1785852946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=15vnxRschpsYFHx4zEsIj6+uMHXtX6Eyfofh2Bn83U4=;
	b=t6NWS35dEhlKOVZAfWparVs5a+/4fQneCsE7/CPOcafr01SAShg5Nfxiw8h0t2xoCsCyZC
	QElrvCFV6hxHDYMbs9pFrlgCcexCXQ7vz7GznuTIJy4nCvQGJq7qIKctkNxA7091MzfhGm
	MNu3M7G47n/JHhxJrTPTyEpY2DDU2iRHZbW9fpV+dGaz3qP/bCbq0h98F9WeZNea9hneQc
	xvJJZvGq2Ivk5gpizD3ftGbFqBpIhfAA5plF8rv+n8Egynmc37IISHGKRQUG+iZ8YYy63B
	8+ZydjP6PJZhKATmeNneGFbUxePkpEfxXGfZakvqsDMoV2ZurxlAGYIvQX9bjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1785852946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=15vnxRschpsYFHx4zEsIj6+uMHXtX6Eyfofh2Bn83U4=;
	b=PjLWKdt3/tRVjplT/mBLuc4NqlwuLPkboFF1ew3bz2M6ENSPSWVmjOAKg/VzNDO+0+gO+i
	L6Lyg3UETKRZ5GBA==
To: Jonathan Corbet <corbet@lwn.net>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	Derek Barbosa <debarbos@redhat.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v6 0/1] Documentation: Add real-time kernel configuration guide
Date: Tue,  4 Aug 2026 16:15:39 +0200
Message-ID: <20260804141541.747704-1-darwi@linutronix.de>
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

Changelog v6
------------

Handle Sashiko review; minor typographical issue.

Changelog v5
------------

https://msgid.link/20260804133746.744212-1-darwi@linutronix.de

Handle Sebastian remarks:

- Reference other documents as Jonathan prefers; i.e., no :doc: tags.
- Coalesce the CPU frequency governors text, and the tracing text.
- Add might_sleep() note to CONFIG_DEBUG_ATOMIC_SLEEP.
- Mention debugfs only as "allowed".
- Mention CONFIG_DEBUG_BUGVERBOSE.
- Do not mention DEBUG_INFO as it's not selectable; mention the
  CONFIG_DEBUG_INFO* selectable variants.

Changelog v4
------------

https://msgid.link/20260716195716.256025-1-darwi@linutronix.de

Handle Sashiko review: Remove a no-longer-referenced link.  Remove
CONFIG_WQ_SYS reference, which I thought it exists due to a quick
misunderstanding of core-api/workqueue.

Changelog v3
------------

https://msgid.link/20260715150147.225715-1-darwi@linutronix.de

CONFIG_EFI_DISABLE_RUNTIME: Mention that system integrators can now assign
the efi_runtime workqueue CPU affinity, then safely pin RT tasks on a
different CPU range.  This is due to:

  https://msgid.link/20260227170103.4042157-1-bigeasy@linutronix.de

now being merged mainline.

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
 .../real-time/kernel-configuration.rst        | 307 ++++++++++++++++++
 2 files changed, 308 insertions(+)
 create mode 100644 Documentation/core-api/real-time/kernel-configuration.rst

base-commit: 075b74841bd0065a3bda3440873c747938e69b68
-- 
2.55.0

