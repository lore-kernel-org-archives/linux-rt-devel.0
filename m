Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4172080FB
	for <linux-rt-devel@lists.linux.dev>; Wed, 12 Feb 2025 10:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739356593; cv=none; b=HyTMGZtsqrWeCdsAvuhVT/my7kK5YUOwt8ROeJka3m0cCCE8gVYOR2tM+NzkRhr1q7vOs5PQPKp9lJd/PQ+Jw/hkbSpKtSX5xBqNSJ3bws7nXXu7kNbF80IEkObtxraM0rBxeEmU2RYGj7Gq3zLWG3sQ7RuZZZ5IZ3DUdhrkK9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739356593; c=relaxed/simple;
	bh=mkHccYxFpw6IWV8gVpwa1KPT8Brq/wgiFwIOvtIyvfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h+ss0FhNSZNF+rx8sOHb8JiBYBo4oM+UHQ00yh6CP1fhgpz/XrdDV3/rL6jLTqU91ALsnav+rGsRmRELAdi3GvuNj5ggGnpQxPw3QuX1KdKcZgywSSbTeVChcJqQhG1XwQkelRy/uBOlVOGB0xFH8M5T6TyqsvKt+tKDMSG0wTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pIezP+wv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R+JyVdlL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pIezP+wv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R+JyVdlL"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739356584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v0V4Zx3GTmtiiX2SMw1wyrim82M3wrqb99wqyWJPfww=;
	b=pIezP+wvklkZjMk1CtsSIWcvWsuIXOBKqxeEE68+fNSSdpiASieVoRqsdNCKk8V5MuQXSt
	GER6KRSmMvTuZoh6VF0vLTTloxJdFO8FYWrlHtvW/TlLWUSAIHah/6F7LnQyGXyGeXbkpK
	H9Ya75zGtfqAg9zlHPoBINOVEmNQI5MS+W8TzSnq9Ir3Ix+7QLfVS1h/3nw2Q4q6YH0sK/
	knxbekKw66Q8fxLpBGtNF66vFJwfxiRA5MN4boOuBwSEeXpd9W3TB2mybP5VeTaG97wBe1
	qdS8gJSPr03ExrnCmbU1Vrtxs4cCD6wgytqIPGHR9GODZ2p7zMzGw5CPosNHVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739356584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v0V4Zx3GTmtiiX2SMw1wyrim82M3wrqb99wqyWJPfww=;
	b=R+JyVdlLpdD39g2mXfGR+1tv5aFKF6PkzC84ug5lSbXE5rn6AnRmJHaTzz4svb0XNUM0Iz
	hCrVOeeIyjb58BCw==
To: linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Waiman Long <longman@redhat.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 2/2] lockdep: Remove disable_irq_lockdep().
Date: Wed, 12 Feb 2025 11:36:19 +0100
Message-ID: <20250212103619.2560503-3-bigeasy@linutronix.de>
In-Reply-To: <20250212103619.2560503-1-bigeasy@linutronix.de>
References: <760e34f9-6034-40e0-82a5-ee9becd24438@roeck-us.net>
 <20250212103619.2560503-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

disable_irq_lockdep() has no users, last one was probabaly removed in
   0b7c874348ea1 ("forcedeth: fix unilateral interrupt disabling in netpoll=
 path")

Remove disable_irq_lockdep().

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/interrupt.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index a1b1be9bf73b2..c782a74d2a304 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -461,14 +461,6 @@ static inline void disable_irq_nosync_lockdep_irqsave(=
unsigned int irq, unsigned
 #endif
 }
=20
-static inline void disable_irq_lockdep(unsigned int irq)
-{
-	disable_irq(irq);
-#ifdef CONFIG_LOCKDEP
-	local_irq_disable();
-#endif
-}
-
 static inline void enable_irq_lockdep(unsigned int irq)
 {
 #if defined(CONFIG_LOCKDEP) && !defined(CONFIG_PREEMPT_RT)
--=20
2.47.2

