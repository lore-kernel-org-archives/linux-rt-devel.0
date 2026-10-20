Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792529772;
	b=C12tPMOtPDpXyFfgZvFml2Kxap/H0igL1ZbFqtDPkN0lQTM8iXHZAjYwxYsOBHgatUaA
	 bg9kuQGmS9KK2cMdpwjihC+G2ilFoGTno9Vy0q3yLirfHzEq7l8BY54F8h6h1g40u00BJ
	 52i4DehP1thcTmj+zkPhIN2zBToytUlTT3IwcRqcZvJF/gkma/1rYTWd1bKR6Ti5Bz/TC
	 2zhmvwQQYp2km7b5JlG68Rj/yZ/biVu09lGFyRfjclcKM7daIYBK9MOnEG1785sVQNZ2S
	 2bkhqmCNoeAQAknGXc3x6cVUWvOlyyW3SImllINsfMohgowqtrYUL1XxU9HCVCyyOxw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792529772;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=sl+ao6jj/EJqVd8mitMcxYql8KlVrUDpfsHnTJtiC1U=;
	b=jpSVCOnV06sWQC2ofndi8mjzvBqaT8LdS9N3OrH3wWOYXcmV1vmONE+vZ/qjyEd2H+Z/
	 VUiaCivMoed6rrxw59EVLgfHX80GFhjoSFJniDXZF5mTkORkRLURloytC0NUUGkDKrLKC
	 QiQHNe+4AwNXNytRWTN6JgmSTjV4wW2FoTXYm4j8PmhIPlz1RCq+G8qhmHC0j95O6yWvZ
	 9xONhcRgU/qiy3HfsLVY6Nw0NZ8+KiydgxL7M+Bw09/G9RpDjVp+Xtz4c6PBBHKopk4NE
	 8cRIziF84rnl3S1HQuZpqGj7H+lpbb01/diQ0TaGH+w9RVzWBabv5kHBDwqgabWqUTQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nuro.ai;
	spf=pass smtp.mailfrom=nuro.ai;
	dkim=pass header.d=nuro.ai header.i=@nuro.ai header.a=rsa-sha256 header.s=google header.b=JUKGnpZY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0CD606A324
	for <linux-rt-devel@lists.linux.dev>; Tue, 20 Oct 2026 20:56:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE0CD606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nuro.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuro.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nuro.ai header.i=@nuro.ai header.a=rsa-sha256 header.s=google header.b=JUKGnpZY
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-36681e85e87so1658493eec.1
        for <linux-rt-devel@lists.linux.dev>; Tue, 20 Oct 2026 13:56:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792529766; cv=none;
        d=google.com; s=arc-20260327;
        b=mz5PpH5I/MXC8kcc7FWgjwJqIbvthBhjqsqwZzp/iu1XHTw/sMEJX898lg8SiNAJvS
         1POyezg1NVmawHQj33ggdmlHKkMIemYqmp246n7nzgUe9bpzkddEx2P7QG5IP+WXKs0n
         64DbaHrB3AJoD+24g/g2KO4mVmujOmeMsyafdPvEZHDsfpso6wISLbfiGtEQunLOGM4f
         eHJhgQrmxoWJl/v07YVHu+trMYrFCWrq2xL/R4awispQ/6uIjzcugFhlixtHRIDjoJNH
         Oiru1aSaetG4ofKPXOh3yjZKlad+eWBL4MPR9LqckddccOIqlVy1px+nl6mX1+B9VYDO
         Nf3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sl+ao6jj/EJqVd8mitMcxYql8KlVrUDpfsHnTJtiC1U=;
        fh=oQZa0Rvb/0QWm1SkHRDM8krqUtu/PdXe6N8c8Pfdv2o=;
        b=XQHxWq98vtIPxlGPyqyykVam4Jm6MlOhhSdmKeYWFGT8ECKUqo7LzLaPUEloL5tbai
         Ej/Xbmb7ZDCRTXO81lgnAcFwubTN3oVaEaEw/RDTtH7RcSg3o3rskxNnb5uolsLapwWj
         HqsLaOgdAd1m5iCSv1YDQdXs5s05haC99TeW7raN6zvPIK0ws+2tPbLcvVAIW2Rso6kQ
         oYCoN5PBo2Frc5BYxyzs4bVwP4eNxQF7oaIaGKA7t04pJzNtXc3nQhEpmFDAeME4cTvN
         1fDN/SxF2WIgZ+JmBldBr/SYwRW4xG9ZbIG0z2HlXaiDJpi8X7pGgT+IwbRvEd/a4INb
         zylA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nuro.ai; s=google; t=1792529766; x=1793134566; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sl+ao6jj/EJqVd8mitMcxYql8KlVrUDpfsHnTJtiC1U=;
        b=JUKGnpZYWf57Qr+fdL83IEeX3KvdNnZs59GwgmiRqCOPZw60agpcNHrgphZXryMOfM
         gT6C9RUnXoepvBijEc0jPQPjYUm4a8omKdxvD8X+O+R+gUr4/74FPASUVK7U7ce8gj4V
         nY/dxyBkS+TSsT2kWvNckvhhj2WNns3p/bblhUvcbbXQHSGNxGkXL5pulmO3pq0D/9rn
         vtcwWqYTeMQh9sTu2WnTGt+ThRFYYWGS/026pnx/sJwGtjGFq2qijxDIyzxG5cNspDRj
         ecwzo0iJTuBzuxhzPjc/WuO5oOfZNFxwo5uEzafpi+CFLjYQ3GD04/SRDB76JJyTPoLw
         F+dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792529766; x=1793134566;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sl+ao6jj/EJqVd8mitMcxYql8KlVrUDpfsHnTJtiC1U=;
        b=2CEe1AlU0FQXVGIo4UXoa7zbtQjzCzGKHmR0wIBVeRnUUu0z/LnUk0P+EyCWfL+KRw
         bLYTzDPPSkIshLGtecZPDY+8abMq0fTWo6ikdFn/bjkD8UUyR4KZSTQmoHT7zeSesB0Z
         qqPnv+AGe9uY/56tqIyUPif8r7K4pSP2TOqTsoArPo2+9IwhNu5o76pcs9Vv9AD40O/P
         X8IZMUPIvcQvtYhDwWg9V0Osn0Tbh3Cz+tiTo2Ksf6Ml11jkyaASAYFWmcyS53ptocxm
         4o5LfZh2MKIjWqzyKDwuAyEI6zUF4hkOi74jLJ7fyjtBZ+jK3+lZHOU4Hq4BKmKkKOek
         CuSQ==
X-Forwarded-Encrypted: i=1; AKwUvBz2UEihdlXMOvNOmOWvE5Ep+DM+8Nu3SGFpHQczfJAUpfD6njbLjf+4Kr0HpbC5ixXdZh6VU7B9CpaP6XQEWQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYL+Gn9t8Y6ncmpGAsKfqL/IcUBOWsbDcM/3t8QRzK2EAEU/w50+
	W7vbvdZhbrd4N+jkl/13uvmHj6e2GATp+i5r5y4XINVdYFFciBkzBrOTiAO0h4g8JCM8QFKJ4OA
	PK6xDEOjWuYj11NYmONt4RAR7xcX7uyulGGqUVWiT4A==
X-Gm-Gg: AYBFou33LpGi+QE0j32U5+Wz62eZrMytYbCTqyX9dEwqSrF3ovDeig4hgIYSfiqCL1V
	cPBA4HCD2U2Yb7EtzroI6pvvHSzHzgl9cUU0x9FrqBGOJMcnj2XaUxoEWcH0S8WE5PrMYN6JAAx
	grmvddbGshCVw8hWQbGpy2VOQo4ZJSQS+ENMRHFymGkYd4QJMKpe+P1XxbU0wvicHy7U23+2mUX
	sri80obDG4o7Xw7J/DcSDfMHExp1+Dbh9LTRGqU1hOjHZw5S4U9niJaeSJimXN89o2AS4Z4i5yA
	uVjwkFUAZ7BIDewvF/ycdKJCwaUzPAPKL+W2jLjH+lNDnVGwKlj2GBdQJovqwLdc2ztVV2FG9Gg
	4MYHzkkzsm6jdJDKHEP7UWu9qI1eIo08spXjv
X-Received: by 2002:a05:693c:60cf:b0:353:8205:8558 with SMTP id
 5a478bee46e88-3674b82ad86mr744900eec.5.1792529765608; Tue, 20 Oct 2026
 13:56:05 -0700 (PDT)
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261019174258.1375583-1-jkain@nuro.ai> <CAL4WiipkRkOnc_QJ51g6_9uB=pTeCSp6U8L-YVD2ytuZn4g5Qg@mail.gmail.com>
In-Reply-To: <CAL4WiipkRkOnc_QJ51g6_9uB=pTeCSp6U8L-YVD2ytuZn4g5Qg@mail.gmail.com>
From: Joseph Kain <jkain@nuro.ai>
Date: Tue, 20 Oct 2026 13:55:47 -0700
X-Gm-Features: AclHuK-crS7z_XIcQyguixXXCUEme6bZ9BWpgUYG6WSh9lO_ed8dYy8vP4sPrPk
Message-ID: <CA+Y90Pg5UaL9WkaGghc3PZadrsN+ud-vY89aE3xuZ3UjUxz9Ww@mail.gmail.com>
Subject: Re: [PATCH net v6] net: schedule a purge when the defer queue rejects
 a free
To: Eric Dumazet <edumazet@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, kuniyu@google.com, 
	kerneljasonxing@gmail.com, bigeasy@linutronix.de, clrkwllms@kernel.org, 
	rostedt@goodmis.org, linux-rt-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 10:58=E2=80=AFAM Eric Dumazet <edumazet@kernel.org>=
 wrote:
>
> Say not to very verbose changelog, that nobody will read.
>
> Since commit 844c9db7f7f5 ("net: use llist for sd->defer_list"),
> skb_attempt_defer_free() increments sdn->defer_count before testing
> it against skb_defer_max, and keeps the increment when it rejects.
> __skb_defer_free_flush() returns early on an empty list without
> clearing the counter.
>

Review bots found that:

1. skb_defer_max=3D0 still latches.

proc_do_skb_defer_max() publishes the new value before it calls
static_branch_enable(), so a producer can read skb_defer_max=3D0,
increment, and reject with an empty list, which skips the kick.
__skb_defer_free_flush() then returns early without clearing. Restoring
any limit at or below the count that accumulated leaves every later
producer rejecting on an empty list. On 6.18 through 7.0, which the
Fixes: tag targets, there is no skb_defer_disable_key at all, so there it
is deterministic rather than a race.

2. The kick does not coalesce the way I said it did.

trigger_rx_softirq() clears sd->defer_ipi_scheduled as soon as the IPI
runs, before the list is drained, so if the owner has BHs disabled the
next rejection sends another IPI. With use_backlog_threads(),
kick_defer_list_purge() also takes sd->input_pkt_queue.lock before it
tests NAPI_STATE_SCHED, and on PREEMPT_RT that is a remote
spin_lock_irqsave() per rejected free. This series started from
sd->defer_lock contention on this same path, so I would rather not ship
that.


For v7 I plan to restore the empty-list clear in the flush which covers 1
(but was dropped in v3).  I=E2=80=99ll keep a kick for the case where the
owner never raises NET_RX on its own, but bound it.

The bound is what I am unsure of. Kicking only on the first rejection
after the limit is crossed costs one IPI per overflow, but nothing
retries if that one does not land. Would you prefer that, or something
that keeps retrying?
