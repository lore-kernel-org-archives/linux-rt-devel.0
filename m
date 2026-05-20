Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7E43B0AF3
	for <linux-rt-devel@lists.linux.dev>; Wed, 20 May 2026 08:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779266428; cv=none; b=O7qSGZD6OhAl95hyUNm6c7cRy6DM/iH4EpBpz5Lj2RT/FuwG/p/HW4F3JnrpNnhqfOW4xfCzPxSzAf46qX2XAtQYzCl7Pe1OIXvVUxkQIZN5PBRxP4X2SD2ppZ+8cDdNN0fH636hnF4CeMILkCDxitg5BsDoo7DQvqiSVnSQ+rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779266428; c=relaxed/simple;
	bh=qVILxSYSWhU7taL0ecIo2aAMmiE0rBSf1uXPN8hTrzM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GkRE87dXRdWMEzYyDakMsDWxDlq9ckCj4nutnrVZDKWmgAazwMWnQPE7vGry6j5xzKleHd8y05WCVPjHfWLXYDNzBIDhAwrdt9eeBrd3Rn8GZcOxZ8bqRFsc9OwL3YBepsrfV7Fn/OEUvLltL2YjH6oGTfqSG45PtrrFHuUX5/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rcPLdIfQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HZMylKGg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rcPLdIfQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HZMylKGg"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779266425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9KBbpSpmlfV1Uq+CO2cJL6w9JaFSW+b5NIk73Ezoxgo=;
	b=rcPLdIfQCuQ6NEGJYet1xiJ6CEtZYsHd6vlf3yRX+zMEmEOqVEwibUnEMrmLvirVyRqSYp
	uPX1iKq9S/ckXBcilPzHxln+OiA9Rlox+GZrpqFaBugh4DvUUJ3S2LYAJ4kmbFld1/gYhw
	ppPLSXhy27zwa3uGNqiyUsWU2p9Wy67WrtJjdFWCH2vA3tigg5c59DHn7fUKCjvJWW3Zfn
	XK4o4d/ocx7KB+GL4dsvmln5lyTl4qy/KDnUKhcNGxITt+ZD6CMbipjpAHE5hNtrIaD9FR
	jnP/Q/pIH71DIfX4EYDLSVgcBtamYirg14iOrFfxU+NLjaxZNNtFiCYQhPuEyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779266425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9KBbpSpmlfV1Uq+CO2cJL6w9JaFSW+b5NIk73Ezoxgo=;
	b=HZMylKGgI9FhxbnPUH+fuDFqNrVMfJxq4D2qaTnrWyLByrZYd59xeDi8DuteUELNZxnKOE
	wvb78wqYSqh+QCDg==
Date: Wed, 20 May 2026 10:40:04 +0200
Subject: [PATCH v3 5/5] lib/vsprintf: Always check interrupt context
 restrictions
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260520-restricted-pointers-final-v3-5-76bca6a6ab3f@linutronix.de>
References: <20260520-restricted-pointers-final-v3-0-76bca6a6ab3f@linutronix.de>
In-Reply-To: <20260520-restricted-pointers-final-v3-0-76bca6a6ab3f@linutronix.de>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Will Deacon <will@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Waiman Long <longman@redhat.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779266417; l=897;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=qVILxSYSWhU7taL0ecIo2aAMmiE0rBSf1uXPN8hTrzM=;
 b=Zy8bPZOakZIDYIThK+ju4GHZ1EZJBNDZjeEcOO+Y+vMOsyDH29dyCRFBhGq5z8V5C4Dq8jIxp
 5wA8FpZoxhZBM23CSqmke/bYeoLcTxR9tUjPMIleEP+MHyEwHl8jeH2
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

When kptr_restrict is set to '1' restricted pointers can not be used
in IRQ context. As kptr_restrict can change at any time at runtime,
this means that restricted pointers can not be used from IRQ context
in general.

Add some assertions to detect misuse early, independently of the
runtime configuration of the test system.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 lib/vsprintf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 69dbd22f0e9e..c48a771a3ac3 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -871,6 +871,8 @@ char *restricted_pointer(char *buf, char *end, const void *ptr,
 
 	guard(lock_map_acquire)(&vsprintf_restricted_pointer_map);
 
+	lockdep_assert(in_task());
+
 	switch (kptr_restrict) {
 	case 0:
 		/* Handle as %p, hash and do _not_ leak addresses. */

-- 
2.54.0

