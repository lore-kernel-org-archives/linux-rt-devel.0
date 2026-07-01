Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B48B27280A
	for <linux-rt-devel@lists.linux.dev>; Wed,  1 Jul 2026 16:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782923768; cv=none; b=BY14KLwZO1AsTK1G8YwblDkdWxNmUMd2bSNYRMn80eirRN0390gUUqFTSGg6yQbeszfoYZRusdwGPBJ4h5FFmocePWb9xwy/fGoeTmr3LJ3wZdNnyJLSk6+BRGTam6R1Lia5Y7EtJ5BBDUD/Ly4DKPZTOckABKOsnAstwzj7s+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782923768; c=relaxed/simple;
	bh=dGqjQNYHP3AKe7QVSruy5pq6XjGy/UjGWXch8I2wCqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gkqnSGcNrW6uF/ZPBQwUr144WjVF7zQX5Gy3iA2xXGKr0ulN30QWWGy7CDOJelwrJRsZkiNDXxbzEjgjJ21mKQzJxp1LlGj5hue+xENdnFn3JGoBN5gsMp5DwxhCTrjGCTfwwzLy2sEjeby8gYSpuGA+O4WormyORikoPrjfDVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hIMhVLbn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Vh7it3+N; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hIMhVLbn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Vh7it3+N"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782923762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5H2RMSAKmJoGY+DThXDisriGJ1Qn+QePthjBOB1RimY=;
	b=hIMhVLbnIB1PefXMfbm/EMOg6mKFIdrxotbTAq78FklFXkHvLDKnnSOxQGjheeBqoF+MSB
	/RJ4wpAY1LpNxpoVDRXbyAs+pN3f1cAQwzgMMKni2TlSK1vj0Hf1dCEaqh/FXpK06yjGge
	EVdlksNkeovxiIEjUmifPEL7CE39QBFn9C/gdeGWpqqez/TC05uqc4TFrOUVcvZq4VIwAC
	XONzSq5r1p+4yRorHSk41mnvX3+zTgTa/HfRu8YLmF/NWUA2wdGJRCY6Y3/6lB536zhmiK
	3iwPrJExYb5vG2NpdnKKYxqPRDJseAPMvUbZXy5Qp38rtXYFUye0bggCE0pAUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782923762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5H2RMSAKmJoGY+DThXDisriGJ1Qn+QePthjBOB1RimY=;
	b=Vh7it3+NUYTxkGM8g0mUS+gepqlrvG5Vqbdg+e9N/H7WDBq8zzK8W14/7+nVpp0qR29B8g
	o6XJBK9itxGbjWCA==
To: Kuniyuki Iwashima <kuniyu@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH 1/2] af_unix: Do not wait for garbage collector in sendmsg()
Date: Wed,  1 Jul 2026 18:35:53 +0200
Message-ID: <e663a83195f3d9f6d7ad4907c37ae3e45c151062.1782922354.git.namcao@linutronix.de>
In-Reply-To: <cover.1782922354.git.namcao@linutronix.de>
References: <cover.1782922354.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

AF_UNIX sockets' sendmsg() schedules and blocks on the garbage collector if
user has too many inflight unix sockets. This causes real-time issues, as
high priority processes who do need to send lots of unix sockets get
blocked by the garbage collector which runs as workqueue, causing a
priority inversion scenario.

The reason for blocking on garbage collector goes back to 2008, when
it was reported that "Local/unprivileged users can cause soft lockups
and take out system processes by triggering the OOM killer":
https://bugzilla.redhat.com/show_bug.cgi?id=3D470201

The soft lockup was because a process can keep queueing AF_UNIX sockets to
another process that is exiting. Back in 2008, the garbage collector was
run synchronously by the exiting process, therefore keep queueing AF_UNIX
sockets blocks that process from exiting.

The solution to that issue was forcing sendmsg() to wait for ongoing
garbage collector.

The OOM killer issue was brought up again in 2010:
https://lore.kernel.org/lkml/AANLkTi=3DQ967xpX0KLMwX-=3D_4_1AKO5wjHEuJ1TrNj=
Cj9@mail.gmail.com/

To resolve that report, beside blocking on the garbage collector, sendmsg()
also schedules the garbage collector if the number of inflight AF_UNIX
sockets in the system is too high.

Then in 2015, once again, the OOM killer problem was brought up:
https://lore.kernel.org/lkml/20151228141435.GA13351@1wt.eu/

That time, the issue was resolved by disallowing a user from having more
inflight AF_UNIX sockets than their RLIMIT_NOFILE. That was done by commit
712f4aad406b ("unix: properly account for FDs passed over unix sockets")
and commit 415e3d3e90ce ("unix: correctly track in-flight fds in sending
process user_struct").

Now, sendmsg() does not have to block on the garbage collector anymore,
because:

  - The OOM killer issue has already been addressed by checking
    RLIMIT_NOFILE.

  - The soft lockup issue is no longer relevant, because the garbage
    collector now runs asynchronously since commit d9f21b361333 ("af_unix:
    Try to run GC async.")

Therefore, remove that to prevent priority inversion. Running all the
reproducers from the mentioned bug reports after this patch, no problem is
observed.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 net/unix/garbage.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 0783555e2526..f180c59b3da9 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -300,8 +300,6 @@ int unix_prepare_fpl(struct scm_fp_list *fpl)
 	if (!fpl->edges)
 		goto err;
=20
-	unix_schedule_gc(fpl->user);
-
 	return 0;
=20
 err:
--=20
2.47.3

