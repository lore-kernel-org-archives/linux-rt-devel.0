Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C55407CC0
	for <linux-rt-devel@lists.linux.dev>; Wed,  3 Jun 2026 08:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780474108; cv=none; b=MeO4eeakfyqZa1A8iCrrElowSx5y5Wmgt0EQuAy1LZ6nOTgizX9aJBU0qwlJrtibkZJFm0zXh1ny+LMBoBcevRO2bPO/XII+w7vQhsl51eI2NGSdmdI52NoVZ0TCN0KwhU+jF/ZwSBTWaxSOMSf5FifbIiTolwVzrZhj3WxSbgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780474108; c=relaxed/simple;
	bh=SE8Dwi88Lf1Inohdf6BvMO7M/kjuqgl7K1q1znaGzE4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QEt7V8d2TZDhlo9GO0E8klByPcEi3NyWIi7nnMSclBguW/PztF2jeayu27jFSZiHN8nBUXYb/YIKbLh2AlMfbDC3Bp58+/TiNvvK1tJmsv92x1ZdYtw3iXhLE5qyUklxWMOXQ2/zdTmPNtF/le441hIbEdYa2mfHnBENFbAoxbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=vB5ZLR/f; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Jq5tHoFr; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="vB5ZLR/f";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Jq5tHoFr"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gVgLc1CxQz9tkS;
	Wed,  3 Jun 2026 10:08:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1780474104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pQJmvSGaMSGIUzkPJDwFH479DdXRHj98eq2KmHK4Osw=;
	b=vB5ZLR/fBgWZ+3ZLgqFg0PFTGvzUQhqw0lzNGZaeKfpIPWQNjiNSvXEYSYarAHbTGsVUsc
	ZNijaz0NX3SWhO2wK4leycptIkE9gaxJjJDDgSRIng3Lva604inAthuozayA4zidBRWRTA
	YeLIhBVdjoKXvkkEimKh+Eqk4kG+mk+cPwuSP25QsWpiJwsbv1tHq4Q49AjRI2XYXntQz2
	ZWn46YU5nWfQnkd9IBRlXbW89vUcfROLrUtdmz05Vp3D/XJZmxPq4ZokCChQFnqd3Ugt5H
	rOn6gAl2GqTcY2j12AFh4aUZQ1m7lgJRhW9hmiwJ5jNg6GPYvdim7PpjazAJ6Q==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=Jq5tHoFr;
	spf=pass (outgoing_mbo_mout: domain of manuelebner@mailbox.org designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=manuelebner@mailbox.org
From: Manuel Ebner <manuelebner@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1780474102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pQJmvSGaMSGIUzkPJDwFH479DdXRHj98eq2KmHK4Osw=;
	b=Jq5tHoFrZtAlaRXx3MPWmJ8pjLlYHaL8xK1n2wRND6WCBHhIDmwvKNeNLC8bkEG/ayN6pf
	VzfEvmvhQxMJB2Mk4YXWChcIMZEsJtIYcWp0ZP6oB8cp0eeIOc3hQ2jz2bqHIghzBqMTlm
	BhtC/mq/enWGRUfIISQHKda4t7YB7moTT6UzLtmUyyVSWiuwXJfLlvUNx13q1BnCi9JPYS
	8oTDpwULbMZUpm3/uqpAesbyTKE5sN5CGVXugIiIaHrJh6bcirUzbmhbvYIW87L088UYM4
	rROXg4bnjV3tIsnsAGABaQxGURCY4DOjZT4NSOiR7NRURGMe5YoKxWdKo9+nvg==
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-rt-devel@lists.linux.dev (open list:Real-time Linux (PREEMPT_RT)),
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list)
Cc: Manuel Ebner <manuelebner@mailbox.org>
Subject: [PATCH] Documentation: index.rst: add entry of other sub-directory
Date: Wed,  3 Jun 2026 10:04:31 +0200
Message-ID: <20260603080430.344391-2-manuelebner@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 410cd39a8eb029b0e21
X-MBO-RS-META: 41gtn4j6gzzu841n6dqhm3hoki1crmhu
X-Rspamd-Queue-Id: 4gVgLc1CxQz9tkS

add reference to scheduler/sched-rt-group.rst

Signed-off-by: Manuel Ebner <manuelebner@mailbox.org>
---
 Documentation/core-api/real-time/index.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/core-api/real-time/index.rst b/Documentation/core-api/real-time/index.rst
index f08d2395a22c..661b419e7f8f 100644
--- a/Documentation/core-api/real-time/index.rst
+++ b/Documentation/core-api/real-time/index.rst
@@ -15,3 +15,4 @@ the required changes compared to a non-PREEMPT_RT configuration.
    differences
    hardware
    architecture-porting
+   Real-Time group scheduling <../../scheduler/sched-rt-group>
-- 
2.54.0

