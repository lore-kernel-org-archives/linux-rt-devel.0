Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794344513;
	b=2dgnONkj5mEoUnRLVx2KG21pgkDLVvySp5eDQH9L8UVKFZwMwg1iQD2QwLqBdMc4NkEV
	 YQ1Hzs8ey+Nrv8yHy4oUjime+SOTl4E3Ca3e3TzTdQmY+7Js8uWi2WYexYSvM7DZfAA2R
	 /AJSJtFz9bLf/osRxCdovi1CL7r3QjhiaSGgywuHuN2ULrG8IFk3LeF5VoJuLgn7UGjth
	 XGlb41CDIxLL6wDugWUPq619QNWmUSj9tzESE1xSG55cInCFIV79kO7rwCsEo4tZFrYIP
	 +UQAc+Lph+GxOhe6BZTfK8GgqPvYqc6/f2AjDIS0DhTJi8obsLN7th+ZFWOncHC0hqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794344513;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=M7R8N2eXWD6+EHKfny1HAblM/aky2ALTwQRlCwbdbPY=;
	b=ROW0KDaFHK2iPeM78xk0w80Thhi3ajZgWudBlii+dfyY3swN1sS5vy+HeNvMgbhiPkpJ
	 791BL0AY8XV6ok9arUVsBXYboTCJbQMShRR224Haml17/1pkCHVAp+kZBVDsVhfA83PYq
	 HCQp5cPjoHyKDGAXJfScMgDdyWCPH9eVGgEGygRA1kdtKZEiqJe2bKzY7IUtWE4BiuJWV
	 GL0OBx2U7CCjFRjr5Fss0YNB5yppXSC7AgJVSnaXgjt4CpT6UaHhZtH5/P6YKWC8KtLBH
	 mLqsDPgk9fQ4Q194rm74PxjloraEzew0+2vLqk06EM1ayGQ9x0OzRY3Pgt/LMYRq/7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=blockcast.net;
	spf=pass smtp.mailfrom=blockcast.net;
	dkim=pass header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=bqTaby4u;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C3B606A326
	for <linux-rt-devel@lists.linux.dev>; Tue, 10 Nov 2026 21:01:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8C3B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=bqTaby4u
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1438d9363fbso1465588c88.0
        for <linux-rt-devel@lists.linux.dev>; Tue, 10 Nov 2026 13:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1794344512; x=1794949312; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M7R8N2eXWD6+EHKfny1HAblM/aky2ALTwQRlCwbdbPY=;
        b=bqTaby4ultilXegOzVNOg1/ns5D4vwgH2dKonibnNzjQqBiI8DO6siaOQY6MHku4Z8
         l4uxW+SOL2YnbsiuzkVFlvIE0P+ZN7+pY/eki3mNlmjrpO+7SsDCUneaB8sNoxXF1hN8
         XAfG38BBDnkTLKbH8Ht0icGng3rWOKag637kFASiphCmpVgS/JSrKCxzARO5YuMPHaX5
         GsuLGVDRvNQKWmXN8HqT+RPONHk2fRfDbz3A7tVC2G4jeddsKlLq/fNMic4mh9pSujZx
         ZHZkSBUGpihfHvg8jrFkypdOIlyzmByxPAfOoCy1Qu4tYUNzzU0xcsmTjvbcTw4T3WgC
         6SlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794344512; x=1794949312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=M7R8N2eXWD6+EHKfny1HAblM/aky2ALTwQRlCwbdbPY=;
        b=Gl2pXy60DpMvu2ouPde7CQh3Bn8ZNnaes5lUdiIwJFa5pxadYFcVbxCEorWoDnYKwX
         LF5U0ltYX6zHFdGGhik7YYDpyOjoHs58IdA4Gy4VVICZt0JoeY8aHzMLg7H02hwub8Wi
         d7Dw+vJJ/aTM7hg+fWdFx5zRrdK9aaQzJw7pvNMXfDXi32n/u5JydpEy0vuMKu1Ki2pU
         5RvclcWx1vJAtI1WSo88IGjZA/a2uDBbkHsLPmUq9SaQhvrx44kpZgP+L1ANFuWu5xwW
         GlOs/2JvjnWZIiz9da/ysgdugqKfvLgPyjMooHX8NP8Ug+iqfqclGd7vp7tpW9KgiV0z
         IKoQ==
X-Forwarded-Encrypted: i=1; AL+hErHMXbjEqVKEgNFo1hRFzYfwTUQ2NqYJRgOpgTMQN0UmRx4Fkkzrbf5bvocgvtQI3skJaBR8/aRHSfUHYCmOWg==@lists.linux.dev
X-Gm-Message-State: APuU4Z/LmWVCdq7knbZqfLB/WSS76i3djWkEonP4P1TWsAHUa0fvpcMN
	nOWcdsU9iZ3+gnq5xl34/ZV/MN028MaqZXpV7O98jTrIHdyhCBhXYwNL13YIsLX4yuA=
X-Gm-Gg: AYBFou2BFJZmhf1gpKm0q2kSMDZV+TRUzR23cBzy18W0PYJJ/pzUBQc4xLPITDzl39p
	cJYs3Ukow6L2ZZ2iGcRHDZ/xW+zihqjQFYH5WUmZkj8SUadbn1eblIODswcuLpbz1GGruJPQvb+
	o5BLtC9xNBtiFgRrCbN+Z1WVme8A2HGcu96hSNhMRexFfdvwCDkGQBhRVONphjelKjDnKdeHhOD
	DHYagt3OI0lnQm87n4HECo4qs2VvVk0m0C/8cM6Q2pG6V0hZ7UsFQ3S3JaX3C72Qk8j4ODd62i1
	JMiDPrg/el0veYZLZHi2IG/n4isz8EAY5lmv9DxWFbZjFM9UmvfsCh6Rq1fN5LUixECDtkMMLOa
	OKaPN4zqzE28xJOQeJM5WP5B3fSGL9e+8OavTGB5vMTv0SeAMJaugRJQwpHUWym2v/dH6tDj5KU
	PCD58KsZIMD+p3EXLLAqxlSsRdZGi5iGQg7UNYqbemD1UT7kJovKM1gRgPpeg747FcxbisPdxC6
	VmW0yiT/bzsqnzYjlTR2ZUn0xg5780003w/xAKZvdvAGIJJuYfNMp+BHur8ohn7VAk8CqN3StEr
	lTbzorK08vho3N6nIsJrCGpY+HXkN2tRt5osALSRgAjiMUcHlgdc6kdTdLYml9NJkjsZBe+xPMe
	t/2vL7Cfm/hG4PyRF
X-Received: by 2002:a05:701b:4516:20b0:14b:1ef8:698d with SMTP id a92af1059eb24-1b3c036c2c0mr73201c88.15.1794344511472;
        Tue, 10 Nov 2026 13:01:51 -0800 (PST)
Received: from devbox.ts.blockcast.net ([2602:f74d:1::32])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b4efc2sm8017033c88.15.2026.11.10.13.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 13:01:50 -0800 (PST)
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
Subject: Re: [PATCH net v5 1/5] amt: fix use-after-free when a Membership Update re-arms a freed tunnel
Date: Tue, 10 Nov 2026 21:01:46 +0000
Message-ID: <20261110210147.100396-1-omar@blockcast.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179423575689.994134.7687724928848317687@kernel.org>
References: <20261105125010.1107546-2-omar@blockcast.net> <179423575689.994134.7687724928848317687@kernel.org>
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

On Mon, 09 Nov 2026 14:49:16 +0000, netdev-bot+sashiko@kernel.org wrote:
> - [High] amt_tunnel_expire() (drivers/net/amt.c:1412) runs on amt_wq.
> - [High] amt_del_group() (drivers/net/amt.c:293) used to free the group
>   node with kfree_rcu().

v6 has superseded this posting; this patch is v6 2/6:
https://lore.kernel.org/netdev/20261107004935.2627329-3-omar@blockcast.net/

Answers below are against v6 and the v7 I am about to post.

> Can this flush deadlock amt_wq? amt_tunnel_expire() runs on amt_wq, and
> so do group_gc_wq and source_gc_wq.

Fixed in v6, and v7 keeps it. Both flushes are gone:
amt_tunnel_expire() and amt_dev_stop() call __amt_group_gc_work()
directly, and the group GC calls __amt_source_gc_work() directly
instead of flushing source_gc_wq. The cancel_delayed_work_sync() calls
left in the GC queue nothing: each takes a pending timer work off its
timer or queue, or waits for a running one on a barrier that
max_active does not count.

> What limits the number of deleted group nodes waiting on group_gc_list?

Nothing, and v6 still has this. max_groups bounds live groups, not
parked ones, and before this series a deleted group went to
kfree_rcu(), so the series introduces the regression.

v7 counts the nodes parked on both GC lists, under the one lock that
now protects both, and queues the drain of both lists at once when the
count reaches AMT_GC_KICK (2048). A parked group keeps its 256 source
hash heads, so it is a kmalloc-4k object, and 2048 of them is about
8 MiB; the kick keeps the backlog near that instead of letting it grow
for up to 30 seconds. A periodic drain that ends with that many parked
again re-arms at 0 rather than after the interval.

> When the GC finally runs, __amt_group_gc_work() walks the whole spliced
> list with no cond_resched():

v7 adds cond_resched() after each node in both drains. They run only in
process context, with no spinlock or RCU read-side section held. The
kick also bounds what amt_dev_stop() frees in its drain under RTNL.

> Is 0 safe to use here as the "never refreshed" value for last_seen?

Fixed in v6: 2/6 stores "jiffies ?: 1", and 6/6, where every tunnel is
stamped at creation, drops the special case.

> Could the commit message describe each of these failures? Alternatively,
> could they be split into separate patches, each with its own Fixes tag,

v7 keeps one patch, since the tunnel and node fixes share the same
helpers and the same tunnel->lock rules, but its message now names each
failure: (1) as the amt_dev_stop()/amt_tunnel_expire() double
list_del_rcu() and free, (3) and (4) as frees after only
cancel_delayed_work(), and two more races in the timer work: parent
pointers read before tunnel->lock or RCU, and a second destroy or
delete after waiting on tunnel->lock. It carries both tags:

Fixes: cbc21dc1cfe9 ("amt: add data plane of amt interface")
Fixes: bc54e49c140b ("amt: add multicast(IGMP) report message handler")

Both went into v5.16, so stable reach is unchanged.

On (2): every walker of a group's source hash, the report handlers and
amt_group_work(), holds tunnel->lock, as does every caller of
amt_destroy_source(), so I don't find a reader that can follow
snode->node onto the GC list. v7 still gives sources and groups a
gc_node of their own, and says it is hardening.
