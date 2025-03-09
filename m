Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B17F1DED48
	for <linux-rt-devel@lists.linux.dev>; Sun,  9 Mar 2025 14:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741531633; cv=none; b=ZL/ChmpwlXE6VdXXqm0cpziRq8K4hZbD3N0hzmbWtNNfyvSMU6TXvuREH7a8xpqu+CwbX/mtY7HoorNoKNDiPC7h6uVu3J7XZVd8fLg73wxfqrMORRr8dCXMugl3IpAYH9lyr/mk6kVSqq/kHCyxERXJ4493uNij6XvoEsLP3pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741531633; c=relaxed/simple;
	bh=F1kbwpgJmR1zHtLiC9koc5ViAJJGL+nwkPx/E48SIGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lOT0KJHS4qirLi6qrL6c1ZBAsBZ4w9+omnW7HbsjJE0y6Ke3ahxHh2FeLFGaOptATjb63/Ya6GOtUZrFV3P1wXtS7vT1znVyX5gwxOrN2V6MjPlpNwjQVnP0QsfS/cU9tHNvcjRncVQAobyJFlsIZya6fbEdQAucF4jrl1naJ88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Xm3j+Syp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8h6gbpWm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Xm3j+Syp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8h6gbpWm"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741531629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A2ZfTOQ7bazBpuxxNL69TQ5pB9eD/ZAtsuHrg3a9Qco=;
	b=Xm3j+SypjJFItlmGqocigdv3RPKz+Oyb9oJhhvh5PMRhY3f+NjgiKQjwArQuwAg9eezEPq
	fU2FB32NGkz3VFrZmKgja7JgKjopwptw7zIC4ZE4J4ID/+2BnhXBYYme4HjFqQDrL99Hc/
	2k85VpoJVDK6WPchEseXN98CskN/NOzjzneyHw8kKEBczEJl5VX2Snk6Y4e/bCQa/maxL7
	cng7rPhpgkSJgX+HNvrj1VIa83UHnV3q1Iw7IAjoimGlHQRyC7h8USoZo1le5qcFKWa2Ta
	XrUrF1vEh02+DDspFuCZYls3weRdEZrii1IGmy+zLXIBy7OvcOPD+/YXNyvOCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741531629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A2ZfTOQ7bazBpuxxNL69TQ5pB9eD/ZAtsuHrg3a9Qco=;
	b=8h6gbpWmuCXxzaW1c20Zme6bPt03oxUMzD7a/PaOvmVF+f3taCic5r/Jr4eEr+S2L+cwrr
	F24N+X5AptOWZrDw==
To: netdev@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org
Subject: [PATCH net-next 07/18] netfilter: nft_inner: Use nested-BH locking for nft_pcpu_tun_ctx.
Date: Sun,  9 Mar 2025 15:46:42 +0100
Message-ID: <20250309144653.825351-8-bigeasy@linutronix.de>
In-Reply-To: <20250309144653.825351-1-bigeasy@linutronix.de>
References: <20250309144653.825351-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

nft_pcpu_tun_ctx is a per-CPU variable and relies on disabled BH for its
locking. Without per-CPU locking in local_bh_disable() on PREEMPT_RT
this data structure requires explicit locking.

Make a struct with a nft_inner_tun_ctx member (original
nft_pcpu_tun_ctx) and a local_lock_t and use local_lock_nested_bh() for
locking. This change adds only lockdep coverage and does not alter the
functional behaviour for !PREEMPT_RT.

Cc: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Jozsef Kadlecsik <kadlec@netfilter.org>
Cc: netfilter-devel@vger.kernel.org
Cc: coreteam@netfilter.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 net/netfilter/nft_inner.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/net/netfilter/nft_inner.c b/net/netfilter/nft_inner.c
index 817ab978d24a1..c4569d4b92285 100644
--- a/net/netfilter/nft_inner.c
+++ b/net/netfilter/nft_inner.c
@@ -23,7 +23,14 @@
 #include <linux/ip.h>
 #include <linux/ipv6.h>
=20
-static DEFINE_PER_CPU(struct nft_inner_tun_ctx, nft_pcpu_tun_ctx);
+struct nft_inner_tun_ctx_locked {
+	struct nft_inner_tun_ctx ctx;
+	local_lock_t bh_lock;
+};
+
+static DEFINE_PER_CPU(struct nft_inner_tun_ctx_locked, nft_pcpu_tun_ctx) =
=3D {
+	.bh_lock =3D INIT_LOCAL_LOCK(bh_lock),
+};
=20
 /* Same layout as nft_expr but it embeds the private expression data area.=
 */
 struct __nft_expr {
@@ -237,12 +244,15 @@ static bool nft_inner_restore_tun_ctx(const struct nf=
t_pktinfo *pkt,
 	struct nft_inner_tun_ctx *this_cpu_tun_ctx;
=20
 	local_bh_disable();
-	this_cpu_tun_ctx =3D this_cpu_ptr(&nft_pcpu_tun_ctx);
+	local_lock_nested_bh(&nft_pcpu_tun_ctx.bh_lock);
+	this_cpu_tun_ctx =3D this_cpu_ptr(&nft_pcpu_tun_ctx.ctx);
 	if (this_cpu_tun_ctx->cookie !=3D (unsigned long)pkt->skb) {
 		local_bh_enable();
+		local_unlock_nested_bh(&nft_pcpu_tun_ctx.bh_lock);
 		return false;
 	}
 	*tun_ctx =3D *this_cpu_tun_ctx;
+	local_unlock_nested_bh(&nft_pcpu_tun_ctx.bh_lock);
 	local_bh_enable();
=20
 	return true;
@@ -254,9 +264,11 @@ static void nft_inner_save_tun_ctx(const struct nft_pk=
tinfo *pkt,
 	struct nft_inner_tun_ctx *this_cpu_tun_ctx;
=20
 	local_bh_disable();
-	this_cpu_tun_ctx =3D this_cpu_ptr(&nft_pcpu_tun_ctx);
+	local_lock_nested_bh(&nft_pcpu_tun_ctx.bh_lock);
+	this_cpu_tun_ctx =3D this_cpu_ptr(&nft_pcpu_tun_ctx.ctx);
 	if (this_cpu_tun_ctx->cookie !=3D tun_ctx->cookie)
 		*this_cpu_tun_ctx =3D *tun_ctx;
+	local_unlock_nested_bh(&nft_pcpu_tun_ctx.bh_lock);
 	local_bh_enable();
 }
=20
--=20
2.47.2

