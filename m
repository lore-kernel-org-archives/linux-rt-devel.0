Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794344522;
	b=SIbG8Me/rBpdigsliYwVPleYZ8o5PBArO3XMTJsVeASd/QxwRwEfX52pORKg2HaoHZeZ
	 TYL59n47e5gzYjTCi27PhrqJlUydUO5SgX+/0eVfUu7gRZNG0lFKPw7QaFqny6my0l0c9
	 GJ7EIPbBlnDxxW9k9VOfWilv+PJ1wHQK8vRVDCQVhudNu/NE85hvyDTt5+sQ6JbKIpXJI
	 j9DC7AR497TUJeq8qIucwnoFjrKDV6/fg5Rx/gpljTnH2ceivqd2g8D8McL9gQZ0PJL7p
	 mXqfOA+TmxJTnXAN8dMZwa/ACDcncWCUWsPUUi3XfwjEhvrR8pZr1XB7rl76NtLKp8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794344522;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=dy9zjtNbr6qe/+euwDS4ARapr6gYv28sKl4aRiD8Pk8=;
	b=ns1S1foEpevH3k+fQrbLLBM1t0d9iAqafhsPywL4Ya8Y6DtMxYSSOdYRiXlylL34iErQ
	 cKjku2uUCVZwgkLJj2Fi15YU8WdRtf9qthdliu9JHaZV171uCNl8jp9VB10fKoiagGA2c
	 Orq+pnJ0K1uSuygwHxteh1GlIM9LPOUv0noULPzzgmoJt01G6KWrfPDGRcKuCEZacHbdX
	 uEYCfCyP0MEmpyhmPP4WFST3Bh8W+Lzy+ZBrZ+2NuCS/p6V/X9C2OzvsZJO9TPgJfxpcK
	 gs91mIgzJP2VUvVepHCMMFUE3EUE0W2ZQjuelJXxilSfMG9vhXMtbQ0o9neYZL4CEbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=blockcast.net;
	spf=pass smtp.mailfrom=blockcast.net;
	dkim=pass header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=vWUX7cAd;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B895606A321
	for <linux-rt-devel@lists.linux.dev>; Tue, 10 Nov 2026 21:02:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B895606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=vWUX7cAd
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-36f8cdd30beso3887754eec.1
        for <linux-rt-devel@lists.linux.dev>; Tue, 10 Nov 2026 13:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1794344521; x=1794949321; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dy9zjtNbr6qe/+euwDS4ARapr6gYv28sKl4aRiD8Pk8=;
        b=vWUX7cAdSbn7QpO4VKJ+fHYD7ypMnpcG4AyzzKQ5gnsU/tistrWG/7BZSlqPt05nZR
         eatuLfX72i5q8DEo6yDk1wBjuqBLiTAxw0lQltXVqa4zDJFmfejAU8h+KrSU2tCTBpXM
         g5SO9jH0dGjxDeTlY+fh25WoEZte/7oQwXf9gdEBxHGM5BjqpKuVvhuy+blPZrPPCz5P
         Ot62ZuaFW/USVlvMawIXzoEt73WAQgwzhcbjE2yH2zOaLR/Zcp3ka98u7IyW+BGQWh0v
         IjofhXzITAl/CahIoblDfAHIMN4Uhj1GsDcf28Zs15pvfyZ3hd8ElEWyOj6D2H3vkdgO
         Rqqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794344521; x=1794949321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dy9zjtNbr6qe/+euwDS4ARapr6gYv28sKl4aRiD8Pk8=;
        b=xz5vr4fUhz2i8BrjpGkHA0CvRhMvdJAm6V3SCa4asZblQzzdF1yN5RQuTGgdwtJ5zi
         XtrBzbPYUb4mtmlyI5R0lhJwqmaxYJHT/F/yd1ykEcIFU1uHhdFSc7IMLDSY5m6ByagD
         65MNyqLfw0yblXpyDHjrxIS+dAOtQ4dgDM42tsAsUw+33rPux6fFFD/sX4w3iBpU7Gaq
         vXY8nLbrInLeEXGcpSjzhk0D+wajKuo3zWLuMjhbBuRbs6KZqyB5mH9QF8rCjmMbFEnV
         bhDY7KrTQovh0+jteJDIgxHJdLywFUdWF7j8YnBgI2022918POZ66hFQ6GYuBFQw+3xJ
         c8tg==
X-Forwarded-Encrypted: i=1; AL+hErEJULzipHDgjtoyPC2SyXNB3lNEgEu4t9WC6keG4AVxiiLXDrR8bY26ffiriXJpeme7oBKX5uqKPgRCMbW5jQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z9eXjZ9RtLboSLHLJgfk/EC4kvWbh7dFFiAq8rOsDCiqjdZfNQ0
	DPYKTIS3OHAhlnA99/4XuB6laz9gtOPKWv2bMcSH/X2Qy5tL7lHWQ8/lVlwNJmt9kDs=
X-Gm-Gg: AYBFou3BYqGspKeteTsUrvcfIKmhoq4ILUQFZ5vRF9bV3bjmDaL7+RCBR8z5ajz1PP7
	Lf+KtB7co61GrerhzK4LxPkY4gjYYIXOY2cD7+g/4osMyFmHpDmifl4+wGQZz6ovAoBec0+rYge
	u0wzNd736w9+liwAZTjg0B3vpcckJY91c77gZKMDyuaSOczBR+GK7trnJGWZoY9Hj60KIjraRlI
	tDlvFK2vCsHuEZVwXlY3Y6wAhxVmAj86ni0SacR5RecK1rTFgPAi3XL0Mu884U3gDZXzmx0sfn6
	tNnKN78DTJCBv85sq07otRPROVF1DYZWz91+dY6LfB7P3q1fy8ir/t1uFlVUYPzEXKp3m4e1SVS
	WA7aNcDkmwpNLb/RcAxIFyGsXYg21gFQ0la/zUHjdFvF1vX8ojOSt5cutb9IIaHpvCS924s8OVY
	WHvX5etoISimB2RNk1ShRNFSAPJxhVtHypEjhf6Lv22hw4vyNMVHApqLR2hcwu8L4swmeSDODVS
	tToqH6hJDhYdt8xWfErjzQZVK4BZRPqlerccLu4SHss3n0VzL2S5xlCOvjzG20lhYF1zPLRwh1h
	kgGo1nK1VUhpiRVtb+1NVM8MYJda7+edDjYNJtJbMp48J5uhyA6J5l1GSZr4p5yhj5Rhdtk=
X-Received: by 2002:a05:693c:414c:20b0:376:703c:8819 with SMTP id 5a478bee46e88-37687211c61mr720145eec.38.1794344521014;
        Tue, 10 Nov 2026 13:02:01 -0800 (PST)
Received: from devbox.ts.blockcast.net ([2602:f74d:1::32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520512b6asm8770814eec.10.2026.11.10.13.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 13:02:00 -0800 (PST)
From: Omar Ramadan <omar@blockcast.net>
To: netdev-bot+sashiko@kernel.org
Cc: ap420073@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	rostedt@goodmis.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH net v5 5/5] amt: harden relay authentication and teardown
Date: Tue, 10 Nov 2026 21:01:51 +0000
Message-ID: <20261110210158.103856-1-omar@blockcast.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179423576119.994134.11181391213411379311@kernel.org>
References: <20261105125010.1107546-6-omar@blockcast.net> <179423576119.994134.11181391213411379311@kernel.org>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 09 Nov 2026 14:49:21 +0000, netdev-bot+sashiko@kernel.org wrote:
> - [Medium] The patch makes several security-relevant behaviour changes
>   that the changelog does not state.
> - [Medium] AMT_MAX_TUNNELS_PER_SRC is fixed at 16, but the global table
>   size amt->max_tunnels can be set by the administrator.

v6 has superseded this posting; this patch is v6 6/6, "amt: create
relay tunnels only from authenticated Updates":
https://lore.kernel.org/netdev/20261107004935.2627329-7-omar@blockcast.net/

Both Medium findings are real, and v6 does not address them. The v7 I am
about to post does.

> Should the changelog describe a few more behaviour changes?

Yes. v7's changelog states all three:

- Key seeding: b9022b53adad seeded the secret after amt_socket_create(),
  when there was no receive path yet, and cbc21dc1cfe9 added amt_rcv()
  and the per-tunnel copy of the key without moving it. Since then a
  Request arriving during amt_dev_open() could get a tunnel whose MAC
  used an all-zero key (first open) or the previous key, for the
  tunnel's whole life. The existing Fixes: cbc21dc1cfe9 covers it.

- Expiry: a MAC is now accepted for 180 to 240 seconds after the Query
  that carried it (60 second rotation, four generations kept). RFC 7450
  5.2.3.5.4 has the gateway start a query timer it SHOULD compute from
  QQIC (125 seconds here), and 5.2.3.5.5 has it send a new Request when
  that fires; the in-tree gateway re-Requests every two seconds while
  its Requests are answered. A gateway that never re-Requests worked
  indefinitely before and now has its Updates dropped as Invalid MAC.
  So is the first Update after a new join from a gateway that, as
  5.2.3.5.4 also allows, runs a longer timer while it has no
  subscriptions: it is dropped until that gateway's next Request.

- Replay: any (nonce, MAC) pair minted for the address and port within
  that window is accepted, not only the latest Request's. The MAC never
  covered the encapsulated report, so this changes only how long a pair
  seen by an on-path observer stays usable; off-path senders still
  cannot produce one.

> Could the cap be derived from max_tunnels instead, for example
> min(16, max(1, max_tunnels / 8)), which needs no uAPI?

Yes, v7 does exactly that, at both the Request and the Update sites:

	static u32 amt_max_tunnels_per_src(const struct amt_dev *amt)
	{
		return clamp_t(u32, amt->max_tunnels / 8, 1,
			       AMT_MAX_TUNNELS_PER_SRC);
	}

That is 16 at the default 128 slots and 2 at 16. Below 16 slots it is
1, so there only one endpoint per address gets a tunnel. A configurable
limit stays net-next material.

> Is "teardown" accurate in the subject?

Fixed in v6: the subject is above, and the amt.h comment churn is gone.
The netif_running() recheck under amt->lock in
amt_tunnel_get_or_create() was still undocumented in v6; v7's changelog
explains it: dev_close() clears the running state before amt_dev_stop()
drains the list under amt->lock, so an Update still being received
cannot link a tunnel after the drain.

> Do these two comments hold on the renewal path?

Fixed in v6. The comments now describe what the code enforces ("no
tunnel state is created or changed", "No per-source state is read or
created"), which holds on the renewal path too.

> Does this need amt->lock?

No, but v7 keeps it. The full check is advisory, since
amt_tunnel_get_or_create() repeats it under the lock, and the lock is
held only for an O(1) snapshot, so a lockless read here would save a
lock round trip per Request. That is an optimization rather than a fix,
so I'm leaving it for net-next. v6 already reworded the comment so it
no longer claims more than that ("a Request holds amt->lock only for
this O(1) snapshot"), and v7 keeps it.
