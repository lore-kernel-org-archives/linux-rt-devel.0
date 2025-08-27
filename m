Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A71192B84
	for <linux-rt-devel@lists.linux.dev>; Wed, 27 Aug 2025 08:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756282685; cv=none; b=NO1WbfYlC3OZxt6NfkNCkrHIncsIYtt/DQwEbEIbu+aJYJAqt0ZTvagiCuudmGoBq36szh+HZCIN4EZPOycNvJKJVhnb+scBmZCc88swH6IWwluIcBxBQrdCj9iMYZW3obwVHdIk9FR5eVG4K6HX38rsLNvZsPr8ddOIRMlG890=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756282685; c=relaxed/simple;
	bh=j1gasdhXkQiRVlcWtkLIqfcSVl2uyD++fgr5+eH4CjY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hAMxSw0xHtVa/sObX2wJ5wx5KanMAYtbvDrD9EQZafbW7PU+ZM/1vwwCfYL3JTKwQbVAktod0G6HqnXbe5CwOGtTdGIuB20VRj/52aL7U2wpDKJGGNBBdq3ZDtDDyKKEOWBXNs4KEeIBj97HCWz6f6NJhFjpAzYL46KsGK0KGB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5609b494831e11f0b29709d653e92f7d-20250827
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:32f14093-4530-4441-b84a-681ff4f22a0c,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:1bff4e9324a4d49c2787a7718dca3f61,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|83|102|850,TC:nil,Content:0|50,EDM
	:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 5609b494831e11f0b29709d653e92f7d-20250827
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <cuiguoqi@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 866709507; Wed, 27 Aug 2025 16:17:56 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 91B0BE008FAB;
	Wed, 27 Aug 2025 16:17:54 +0800 (CST)
X-ns-mid: postfix-68AEBF31-467343652
Received: from localhost.localdomain (unknown [10.41.103.97])
	by mail.kylinos.cn (NSMail) with ESMTPA id B7062E008FA3;
	Wed, 27 Aug 2025 16:17:50 +0800 (CST)
From: cuiguoqi <cuiguoqi@kylinos.cn>
To: rostedt@goodmis.org
Cc: bigeasy@linutronix.de,
	bsegall@google.com,
	clrkwllms@kernel.org,
	cuiguoqi@kylinos.cn,
	dietmar.eggemann@arm.com,
	guoqi0226@163.com,
	juri.lelli@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	mgorman@suse.de,
	mingo@redhat.com,
	peterz@infradead.org,
	vincent.guittot@linaro.org,
	vschneid@redhat.com
Subject: Re: [PATCH] sched: Fix race in rt_mutex_pre_schedule by removing non-atomic fetch_and_set
Date: Wed, 27 Aug 2025 16:17:50 +0800
Message-Id: <20250827081750.3606616-1-cuiguoqi@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250826095615.14259d90@gandalf.local.home>
References: <20250826095615.14259d90@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: quoted-printable

The issue arises during EDEADLK testing in `lib/locking-selftest.c` when =
`is_wait_die=3D1`.

In this mode, the current thread's `debug_locks` flag is disabled via `__=
debug_locks_off` (which calls `xchg(&debug_locks, 0)`) during the blockin=
g path of `rt_mutex_slowlock`, specifically in `rt_mutex_slowlock_block()=
`:

  rt_mutex_slowlock()
    rt_mutex_pre_schedule()
      rt_mutex_slowlock_block()
        DEBUG_LOCKS_WARN_ON(ww_ctx->contending_lock)
          __debug_locks_off();  // xchg(&debug_locks, 0)

However, `rt_mutex_post_schedule()` still performs:

  lockdep_assert(fetch_and_set(current->sched_rt_mutex, 0));

Which expands to:

  do {
      WARN_ON(debug_locks && !( ({ int _x =3D current->sched_rt_mutex; cu=
rrent->sched_rt_mutex =3D 0; _x; }) ));
  } while (0)

The generated assembly shows that the entire assertion is conditional on =
`debug_locks`:

  adrp    x0, debug_locks
  ldr     w0, [x0]
  cbz     w0, .label_skip_warn   // Skip WARN if debug_locks =3D=3D 0

This means: if `debug_locks` was cleared earlier, the check on `current->=
sched_rt_mutex` is effectively skipped, and the flag may remain set.

Later, when the same task re-enters `rt_mutex_slowlock`, it calls `lockde=
p_reset()` to re-enable `debug_locks`, but the stale `current->sched_rt_m=
utex` state (left over from the previous lock attempt) causes a false-pos=
itive warning in `rt_mutex_pre_schedule()`:

  WARNING: CPU: 0 PID: 0 at kernel/sched/core.c:7085 rt_mutex_pre_schedul=
e+0xa8/0x108

Because:
  - `rt_mutex_pre_schedule()` asserts `!current->sched_rt_mutex`
  - But the flag was never properly cleared due to the skipped post-sched=
ule check.

This is not a data race on the flag itself, but a **state inconsistency c=
aused by conditional debugging logic** =E2=80=94 the `fetch_and_set` macr=
o is not atomic, but more importantly, the assertion is bypassed when `de=
bug_locks` is off, breaking the expected state transition.

