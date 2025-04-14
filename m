Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E38288C9B
	for <linux-rt-devel@lists.linux.dev>; Mon, 14 Apr 2025 16:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744646900; cv=none; b=cvaIk8rA2fxJxUivyL07t02MDy8OTKRq4tXc6E+7ox4C06qNUCPUtgbPEEFtTYT5SmPQ8SMEPOJav+BVAJz+WA45koFWjKb1pcP04kKVYlg645b4LD0cZsQ/YzTcol0TCoxP8ltJGKywMdPfUGpfa3i4MrTniftYpd+DQEF9+dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744646900; c=relaxed/simple;
	bh=jOJA68RRCsFupoKbIXpdPkdpTgYXhITPGS5zLjDwJlw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bxilx6OgzKb5B89qb2JVuzg2QmMsu8/0lL9/pt/Fr5nvxZMsKJDRKxFZ/MBK3XTE2qE/EvrOBFo9qICRFu3vko7JcEUuX0RWnEoVA3tfIjacnLC9LDDUkZh7Ve7QQCC0rzpA1Zun5cV6IBrOWfi9v555hft5ihheyEZ9gQphZLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0a49cijR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zCl+R/vs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0a49cijR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zCl+R/vs"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744646894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QW4ASRASgx99S0FnlTl8xeHoYCpECC/wdaoXtQZvpSA=;
	b=0a49cijRWl5eLWk6JoQda21CqwPgmTBuS8G6lw+VKdT7cLuPguL05v0I3TFlsyVck5z27r
	BRw4bUwO9BiP+McfpHBoCd0GNSaExDisOB6Wp3teqw8SXFQn4IQ+C5ms17JERKs8C05CnU
	o0hPE6cexH8F1yb7ahY/wSSKGJqcsWQICwU9LQ6BpJEc9T99vMR56Y5qRnJXqpLiPeMZGq
	oF0sGEN3yCNCb0luwb9PrB4kXI8lV19mCBreEgKHSm241RpvMdlI49BrMPjXXOgGsWzEbe
	XJ/Y2fPmroZSH+JKvVMaQbSzFqFZLo82a4XjXfdDZNdhaRNFlajwkETar7qINQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744646894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QW4ASRASgx99S0FnlTl8xeHoYCpECC/wdaoXtQZvpSA=;
	b=zCl+R/vsl1GZ1kyFbN31QTqwrWfUjazZW+akVYZ9S/VoQ3DYyWQvJrtW/pDO72NNaQhplI
	VB9LU3KHg2tTtBDg==
To: netdev@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Allison Henderson <allison.henderson@oracle.com>,
	linux-rdma@vger.kernel.org
Subject: [PATCH net-next v2 16/18] rds: Disable only bottom halves in rds_page_remainder_alloc()
Date: Mon, 14 Apr 2025 18:07:52 +0200
Message-ID: <20250414160754.503321-17-bigeasy@linutronix.de>
In-Reply-To: <20250414160754.503321-1-bigeasy@linutronix.de>
References: <20250414160754.503321-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

rds_page_remainder_alloc() is invoked from a preemptible context or a
tasklet. There is no need to disable interrupts for locking.

Use local_bh_disable() instead of local_irq_save() for locking.

Cc: Allison Henderson <allison.henderson@oracle.com>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 net/rds/page.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/rds/page.c b/net/rds/page.c
index 7cc57e098ddb9..e0dd4f62ea47a 100644
--- a/net/rds/page.c
+++ b/net/rds/page.c
@@ -69,7 +69,6 @@ int rds_page_remainder_alloc(struct scatterlist *scat, un=
signed long bytes,
 			     gfp_t gfp)
 {
 	struct rds_page_remainder *rem;
-	unsigned long flags;
 	struct page *page;
 	int ret;
=20
@@ -88,7 +87,7 @@ int rds_page_remainder_alloc(struct scatterlist *scat, un=
signed long bytes,
 	}
=20
 	rem =3D &per_cpu(rds_page_remainders, get_cpu());
-	local_irq_save(flags);
+	local_bh_disable();
=20
 	while (1) {
 		/* avoid a tiny region getting stuck by tossing it */
@@ -116,13 +115,13 @@ int rds_page_remainder_alloc(struct scatterlist *scat=
, unsigned long bytes,
 		}
=20
 		/* alloc if there is nothing for us to use */
-		local_irq_restore(flags);
+		local_bh_enable();
 		put_cpu();
=20
 		page =3D alloc_page(gfp);
=20
 		rem =3D &per_cpu(rds_page_remainders, get_cpu());
-		local_irq_save(flags);
+		local_bh_disable();
=20
 		if (!page) {
 			ret =3D -ENOMEM;
@@ -140,7 +139,7 @@ int rds_page_remainder_alloc(struct scatterlist *scat, =
unsigned long bytes,
 		rem->r_offset =3D 0;
 	}
=20
-	local_irq_restore(flags);
+	local_bh_enable();
 	put_cpu();
 out:
 	rdsdebug("bytes %lu ret %d %p %u %u\n", bytes, ret,
--=20
2.49.0

