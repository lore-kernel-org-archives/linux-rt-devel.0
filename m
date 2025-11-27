Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8326334397
	for <linux-rt-devel@lists.linux.dev>; Thu, 27 Nov 2025 14:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764254510; cv=none; b=rwBFE165YJXDaU9JAKwW9Djo5tk4Za1FZ12zj2hK2p1RC1Ld4rIAgFrK1LL2boIYklra/Lu7fabmJhuu1iGVKIeAnaxTCvkb8SgyAk/D2IWl1Mv0TxR7eZ3cG4XM6yI/5a53Qvsa5/15n4iWivLDeYE96CvgcN0CYDctfHgN4n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764254510; c=relaxed/simple;
	bh=84jbg3GE1sSrQrD/thjz8Pzqn9ruLtImmCODC3eACO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R5ximmmf7N4v3+aMeXvCgClnmUZOp5QrzC/MaGZqASlfhcZEobBytOedT9aG66njMnvWZ5wen+fVYYEISQBMOfmDpCO66SRb6/pA+jrK7WUyaZbC5JK+IeaBkqMjOCXGkQotK4m9Vu/qArnbeax48/6oo7Hyx//HJQlZwAvofMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U/O9lt0W; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UbrNHrqv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U/O9lt0W";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UbrNHrqv"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764254506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GAY/ZodJ6Qx0lFnZ84+H6KSKHlKsl7r4JpZIQUVxfiE=;
	b=U/O9lt0WP6luJzLryewK9FVs6r9dGFf4BX/qqMy6T2+LRDPtSookwyHUL0w7uJ1yumKkaP
	3sAMnWKUUcS/lq6rUkUUrPQ/ygq8JgBA/jK+cme4QllbPorCpvthAOXiOnc507rXNNmr9y
	2UHNJEmAZgX5FWs1JXmWkQ6c6ksjmwNxf1OlbC8I9P1qUwux1pYd6DFNzAA3wsNIbsVkn1
	4uqfAQU0lPkD4wxYiZI3PeV4/o2GctcIOT1I9282TMCTn/sJ/Zpnw2IMfYIxPmbKwmWxSD
	RivKZYp+iri3PX6epBQ/fmWYBFIbAf1+l1GZHkw9cAOmpO5yAdpVHwdPDIziLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764254506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GAY/ZodJ6Qx0lFnZ84+H6KSKHlKsl7r4JpZIQUVxfiE=;
	b=UbrNHrqvHo9FsjTFENh0pGSyovaSURwm94oQHaDw1J2UqrEb2CfgopumZW/XAtgJGSzrgh
	FjB7atpJSL5jDRCg==
To: linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: tglx@linutronix.de,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 1/2] locking: Add local_locks to MAINTAINERS
Date: Thu, 27 Nov 2025 15:41:39 +0100
Message-ID: <20251127144140.215722-2-bigeasy@linutronix.de>
In-Reply-To: <20251127144140.215722-1-bigeasy@linutronix.de>
References: <20251127144140.215722-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The local_lock_t was never added to the MAINTAINERS file since its
inclusion.

Add local_lock_t to the locking primitives section.

Cc: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Waiman Long <longman@redhat.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6df89b14b521a..6939d27bc1f2d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14535,6 +14535,7 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/c=
ore
 F:	Documentation/locking/
 F:	arch/*/include/asm/spinlock*.h
+F:	include/linux/local_lock*.h
 F:	include/linux/lockdep*.h
 F:	include/linux/mutex*.h
 F:	include/linux/rwlock*.h
--=20
2.51.0

