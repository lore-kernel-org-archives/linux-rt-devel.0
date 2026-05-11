Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C52637E30D;
	Mon, 11 May 2026 21:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778536472; cv=none; b=COlMvPOHk+UjmCpMst6NrjZYXCY8i3cyXQm/+ubHSJy/s/FzsXDXcQ4HkqG3hASIzejTjfgzkDgzLGXeTIWDRgisPVIh30x+k+Das7yCptDUnxH5YYSAeIvcvVfsp+UhNYN8UvAYVqGVCs2rCZ/6TGQ+EH4FGA6Lv+golR7fgCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778536472; c=relaxed/simple;
	bh=ybVGTZNKM6RpK1Bw5uiAIw43CoEODvwqm+le06MtQQA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=GEd9IDXCMiQrJUVxtRqJoaAh03gNo3nXzcBFaZJ0lmNfyTdxAh+kUVZ1wCo6ugNN1Q0ETd/28WhZd9qCBvaI9hrV+ScA8JPgwuL5qw0X64BViJ4OLvXBkN8QOySI1oSX00opHIlftfR2+5cSHIQZiG9RsEglYqYnDLwdkHo0lfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=U7HRntmK; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="U7HRntmK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=W6zSjQbkIErgU7eVBwA0hYH3uzutxPSVvMYSfU/Qy9w=; b=U7HRntmKKKsfUy5WBEw8IYMKxC
	NuCagglnvP0NFg9iZeOmCt4b0hv1qYACVbGhhWmhSW5M8vqFjJIzip17LFQQ9ragiok3IamU+Shiy
	XprmM+uCO0rFUVEP2zZHNkpN2mwg24JRGZTBN8lyeGom25QJCKDswuAGbV/xK6MQfAFTWJLjX5tRB
	V4ZzhASq2FEjEfTOsXrQZ5TVk1WHjXwoZJVYYkOLkEIRvZ7Sj98PpFEumBByTfjDETAbSmp3OXvh6
	28zKT6lVB9yOhliVSyQ4SsSOiHZDPF/35J6Urbd9tI7m4NO3VLarEVnfXU4B1GiasUCcEwfOLmU3+
	GCisb5Vw==;
Received: from [179.221.50.101] (helo=toolbx)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wMYZm-009B9h-GX; Mon, 11 May 2026 23:54:10 +0200
From: Helen Koike <koike@igalia.com>
To: tglx@kernel.org,
	bigeasy@linutronix.de,
	peterz@infradead.org,
	linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	koike@igalia.com,
	kernel-dev@igalia.com
Subject: [PATCH] debugobjects: do not fill_pool() if pi_blocked_on
Date: Mon, 11 May 2026 18:53:05 -0300
Message-ID: <20260511215359.3351259-1-koike@igalia.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In RT context, fill_pool() ends up calling rtlock_lock(), which asserts
if pi_blocked_on is set. This can cause an issue in the priority
inheritance logic since the waiter can be overridden.
Do not call it if that is the case.

Fixes: 0af462f19e63 ("debugobject: Ensure pool refill (again)")
Reported-by: syzbot+b8ca586b9fc235f0c0df@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=b8ca586b9fc235f0c0df
Signed-off-by: Helen Koike <koike@igalia.com>
---
 lib/debugobjects.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 12e2e42e6a31..772ddabcbe7d 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -711,6 +711,15 @@ static struct debug_obj *lookup_object_or_alloc(void *addr, struct debug_bucket
 	return NULL;
 }
 
+static inline bool debug_objects_is_pi_blocked_on(void)
+{
+#ifdef CONFIG_RT_MUTEXES
+	return current->pi_blocked_on != NULL;
+#else
+	return false;
+#endif
+}
+
 static void debug_objects_fill_pool(void)
 {
 	if (!static_branch_likely(&obj_cache_enabled))
@@ -727,11 +736,12 @@ static void debug_objects_fill_pool(void)
 
 	/*
 	 * On RT enabled kernels the pool refill must happen in preemptible
-	 * context -- for !RT kernels we rely on the fact that spinlock_t and
-	 * raw_spinlock_t are basically the same type and this lock-type
-	 * inversion works just fine.
+	 * context and not enqueued on an rt_mutex -- for !RT kernels we rely
+	 * on the fact that spinlock_t and raw_spinlock_t are basically the
+	 * same type and this lock-type inversion works just fine.
 	 */
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible() || system_state < SYSTEM_SCHEDULING) {
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || system_state < SYSTEM_SCHEDULING ||
+	    (preemptible() && !debug_objects_is_pi_blocked_on())) {
 		/*
 		 * Annotate away the spinlock_t inside raw_spinlock_t warning
 		 * by temporarily raising the wait-type to LD_WAIT_CONFIG, matching
-- 
2.54.0

