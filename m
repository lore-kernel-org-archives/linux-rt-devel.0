Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793883015;
	b=SJGRQEP+NsHBcVB+wJZoGyEXRT7PbJ3KTJJ4RiKGAhgW9gGjoxg9hc5yaBc2QKiVvcoF
	 vjq5GTay/AYQmGsFYa5Cm3AGcfLPCn3QEcBrfFgnp+d2bt7kmLGweg7DgxZUSTLqV0BiM
	 +yG+wcEqKPWmd6ttAL5k9PeECn0nz5AH11dRoNUvOm5PNTIqSYbFlLWHbLxZ2bifGxWyR
	 R/G9/Ra+SD8XvYK3vg+3eQFNAEc6ZNECONSj2x8x5wIZWrYbJ1OLS8Ig2U/E94EopGQcA
	 6yObKt/AY4LtyWPepypJOduwAcZqh5lhCqCPP4A4OeN5Vr8syvHsNr8KYJ2lqxHpBCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793883015;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=RelRpHTTIUBHZAk4EQyLEmZyhVHOpEokc+ctiSQX2Wo=;
	b=lY5pcFNWpPi55Kpy3oB4jwvzuwg8jGPftNyjRM6xcKIHvL3dJsF9RAiOy+bM2POzeIRR
	 NMEeHRoIsXIQBJ6xEmNb/Rqm7DzGNbHlVo/Qxs8oYw4ymgl6q61A3h58JTbQ26fo10pJ1
	 pvwKcvAXO0KT4log4NsMfpEHpX36jcPYz7k+XhCd4yZoW+oFJ00DCKgyS0s/m5CrkqlwE
	 RIETTIJniN8fu5qD6W3w0fCU/0K1MOB92b4iHXcDlod7QeCL6aoRcDhCR05YGDo4nRFJy
	 d+yxJ/ZnjWT1UYXUab++vgmr+HpyG/zt4MiTbLUmrLy/mX9LvwrYObZ+p+/w9ZNYNNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=blockcast.net;
	spf=pass smtp.mailfrom=blockcast.net;
	dkim=pass header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=mgcEjgDE;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03710606A32E
	for <linux-rt-devel@lists.linux.dev>; Thu,  5 Nov 2026 12:50:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03710606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=mgcEjgDE
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-3514b90bb89so3468173eec.1
        for <linux-rt-devel@lists.linux.dev>; Thu, 05 Nov 2026 04:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1793883014; x=1794487814; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RelRpHTTIUBHZAk4EQyLEmZyhVHOpEokc+ctiSQX2Wo=;
        b=mgcEjgDE/ib5BvKfnjC5yARFfJ06dpXmuG4Y6+rklIcLWuvSb7UadXcro/e9alvKOq
         ejpncbHl1TYOM+sNR/MAvdNIapEo9KtgtwnEGL81mwGOLeegT3YRs5MLpVK7yyruZ1Gs
         ALFLhtPE0GGSZL9IluC71aWrxiHUrp3GFAN00Od69vn7RNbOp3IqZojpX1yz7fUsCy7c
         7b328RiRYK+NNAFgFTxV9yD2HFaO0wKqakYCtOOB5nC8YQ6xtHExrwrbAVA47mPB1YS/
         u1wTkTWQIUiqTbIdUmvMFPOXYJ5tOU88eaIH0RUtWdj587eqG0WqLam7PNH1voyKgGPE
         OclA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793883014; x=1794487814;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RelRpHTTIUBHZAk4EQyLEmZyhVHOpEokc+ctiSQX2Wo=;
        b=Ta3BfSXUVsTQAHF3NKJ0vki4sarAYes/MMcaqR2/1p8tlWVM4TC2GxdcgK6cHAZC06
         h1YpD/agKI9/WeBsVL7XxCcLlD/S1YOhMB9J3aajHOTCNcImJ1UX9j/xrCsaOBgtbFOx
         mI7tlwbRbUnckupLVjREajjmI8z8Dc7dAgrNFT6RK9xyH8QWJkXeiBiMP0jfEDIp38PJ
         A4+HawmFCtgcY7Yip6S+Ppw2lxApsjAibYpj0BARZtGEvAqbTo4V9so9ZpOeijcyaph7
         eLoX8wQXnmW95qv33itsaU1oSMUB+3TR+XjvH3xdpecvLZJV73aFHbrESbQohKpn3o6V
         9HBw==
X-Forwarded-Encrypted: i=1; AKwUvBxhCCQ7NsohqlQ4P5+fKKs1n6VPOSR0cIIfA6zC3GjR9cbeOa3eFrrVfp/LoSASkg+GNUhYof9DiMU3B303PA==@lists.linux.dev
X-Gm-Message-State: APuU4Z9EZ3R1KS2lIJkgCmW/dFO5NszlTvZyggyd0fVgHVmhtPl5Bos2
	UkPRjmktvss0YoUaFTM51boOQH+ONOpOmInlceQnsZejg3r863qPddWM4/W4YNEgMEQ=
X-Gm-Gg: AYBFou2zIPvuG6w5aQ/GqMWWAPHqRJE8nT4qbUySef2x6Dg6eRWV2zeuKc4sEAE5MlK
	cvMGB3YoIuLXSFTjMgZnhqTR/rFqnqOVU/Axs+MVuLYNoOpm9O/BJxMmYvufiw6sctbufZuXA0+
	4TgmnMusm5JeD27cIgpDreehW1ppCrmtvF3UzG84oGOIsUS8vRUuu3hhVmgGNaUgAC/+Syw3SHP
	n+BzMjj4CbbtFo49NqHBDwSPy+hHe7DYvGkOEx40XWQmkqH8maUCqD9UwJEa3w5SKTrNTOsV6e1
	xMrxEoXOIOpRnv69WgEeAFpST6+sVe0KjnmyKge4pSfykzu8EPcOSq0pv8wvF5Gf9XxZR7f8HVR
	/HZebbJzTaUr5wOSzo6ozZM+f85mIeI7QujzdC7ASUrgvDtxXTWLVr8Dw3RmWwIiic8Gu+SitfG
	v3qTuILD0n1dEECYfG8q9Kbf3mMcvJMHPvhW1IC4XAyywUekpU7AUCZDrAarL6JQjMZjOc7QWQQ
	oEWGX//hbBEJ802gShmUIBNC/zme51YvmaISXS/9nxeIrT4ZWSsMIPN89iVypScz3MZWAwIiD1z
	MBXnPgLv0/H+6zxOtOpq4zb+3RRGZnBzwXvA/9kH38BknjGLDiwO6c/XZkSxspIOf06QZIZk
X-Received: by 2002:a05:7301:2a24:b0:36d:48e:82de with SMTP id 5a478bee46e88-36d049e0895mr9351265eec.12.1793883013470;
        Thu, 05 Nov 2026 04:50:13 -0800 (PST)
Received: from devbox.ts.blockcast.net ([2602:f74d:1::32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca39b8eb3sm22527257eec.27.2026.11.05.04.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 04:50:12 -0800 (PST)
From: Omar Ramadan <omar@blockcast.net>
To: Taehee Yoo <ap420073@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH net v5 0/5] amt: relay tunnel lifetime, validation and request-path hardening
Date: Thu,  5 Nov 2026 12:50:05 +0000
Message-ID: <20261105125010.1107546-1-omar@blockcast.net>
X-Mailer: git-send-email 2.43.0
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

This series hardens AMT relay tunnel lifetime, validates gateway input, and
keeps unauthenticated Requests from consuming relay state. The problems
fixed by patches 2-4 were found during the AMT IPv6 outer transport
work, which is not included here.

I am using the existing IPv4 AMT relay and gateway implementation in a
multicast delivery network, where gateways on access networks send IGMP/MLD
membership state through a relay to reach downstream receivers.

The first patch closes the gc_wq re-arm use-after-free and makes teardown
safe for RCU readers and delayed group/source workers. The second rejects
Queries and Data from 0.0.0.0 before relay discovery and revalidates deferred
Queries. The third requires exactly four bytes for IPv4 netlink address
attributes. The fourth makes pre-Query drops visible, avoids counting
successful reports as drops, and uses concurrent-safe TX statistics. The
fifth keeps Requests stateless, authenticates Membership Updates before
allocation, keys state by address and port, bounds per-source admission, and
silently drops failed endpoint admission.

Each commit message now says how its problems were found. The problem in
patch 3 was triggered while writing an IPv6 selftest; the others were
found by review or code inspection.

My reply to Jakub on 2026-10-20 said I had reproduced the lifetime,
authentication, teardown and input-validation issues. That overstated
it: only the problem in patch 3 was triggered at runtime.
https://lore.kernel.org/netdev/20261020105410.7dccf739@kernel.org/

The 2026-10-20 posting was mislabelled v4 in its subjects; its changelog
already read "v5 changes". This posting is the next revision of it.

Changes since the 2026-10-20 posting:
- Patch 1: flush the deferred group/source GC with flush_delayed_work()
  instead of cancel_delayed_work_sync(). Both GC works re-arm only
  themselves, so cancelling them on tunnel expiry or device stop stopped
  periodic GC for good after the first expiry. The flush only reclaims
  promptly; lifetime rests on RCU and the cleared owner pointers, and the
  comment and changelog now say so.
- Patch 1: clear snode->gnode and gnode->tunnel_list with WRITE_ONCE().
  Neither pointer is __rcu, so RCU_INIT_POINTER() drew two new sparse
  errors.
- Patch 1: keep amt_group_work()'s single out: exit and move
  rcu_read_unlock() below the label, instead of open-coding
  rcu_read_unlock() and dev_put() at three exits. Every exit still
  drops RCU and then the timer's device reference.
- Patch 5: drop the paragraph about tunnel liveness checks, which moved
  to patch 1 in the previous revision, and fix one continuation-line
  alignment.
- Patch 5: copy the secret generations in the Update path under a
  seqcount, amt->key_seq, rather than under amt->lock, as the Sashiko
  AI review of the 2026-10-15 posting suggested. Forged Updates now
  take amt->lock only on PREEMPT_RT, to wait for a writer. Requests
  still read key[0], nr_tunnels and max_tunnels in one O(1) amt->lock
  section.
- Patch 5: say in the commit message why one address may hold at most
  16 tunnels.
- All: state how each issue was found, and put Signed-off-by above the
  "---" separator (it was below it in the previous posting, so git am
  dropped it).

Testing: on base-commit below, each patch builds without new warnings
with W=1 C=1 (sparse) for IPv6=y and IPv6=n.
With KASAN and lockdep enabled, tools/testing/selftests/net/amt.sh
passes (6/6) with no splats.

v4 (mislabelled, 2026-10-20): https://lore.kernel.org/netdev/20261020002557.3984927-1-omar@blockcast.net/
v4 (re-posted 2026-10-15): https://lore.kernel.org/netdev/20261015220648.1545576-1-omar@blockcast.net/
v4: https://lore.kernel.org/netdev/20261013175407.947606-1-omar@blockcast.net/
v3: https://lore.kernel.org/netdev/20261012125943.558629-1-omar@blockcast.net/
v2: https://lore.kernel.org/netdev/20261009201455.1904698-1-omar@blockcast.net/
v1: https://lore.kernel.org/netdev/20261008003606.3666617-1-omar@blockcast.net/

Assisted-by: LLM

Omar Ramadan (5):
  amt: fix use-after-free when a Membership Update re-arms a freed
    tunnel
  amt: reject a gateway Query or Data from 0.0.0.0 before a relay is
    learned
  amt: require an exact IPv4-sized IFLA_AMT_{LOCAL,DISCOVERY}_IP
  amt: make pre-query report drops visible
  amt: harden relay authentication and teardown

 drivers/net/amt.c | 550 +++++++++++++++++++++++++++++++++++-----------
 include/net/amt.h |  33 ++-
 2 files changed, 450 insertions(+), 133 deletions(-)


base-commit: 734bef548a96e8774d6eef5dfa2026c6edc4e80b
-- 
2.47.3

