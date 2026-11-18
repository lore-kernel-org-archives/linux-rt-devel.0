Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795012081;
	b=46S62FIbWyDmT5UBUroJN03HTg2BqKKQYaLhJUUPFGHDLhyD5cToKkd5Dt9zHxRwnuX/
	 s2czRmoPLY/rltlwGTHjyMQG201cHLX9Fv3yvjg5V+ZHYubgozso8wzbhQUyV1DYmCgL3
	 Pdj6Oy6OJLto2TiSaLXRbW/ipPMPAgpjijC1rzD0pBbrH66gOnz1KN1sF+3TK+D6nx1gX
	 bZ7FLohYF8GaubPS4Wn9DzwGl8Svx4EfDR42LS8l1wJenX4hgOYKESIP6TywXqy5eenkZ
	 u97R4+lGfYRti3AB5iQDxgqSm8hIAE/uPADforPzIAM/3K4JuNCmy/uEXhTs17rCxRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795012081;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=nZboGS9TzIUKYx8nlJm/8q9o+1lIrW0X9zgljbgU57g=;
	b=v5qZdxrAeCMHo4xZoT2yEkpRW6i5GVE6B3bBsUg3K7AifNgC5h7PARynIoBbZkmyoOyo
	 1OpC0vyB+o+sIbWjRfV+VsmaDdgB44YMsYuyh9c27A5F6urZuu3u24Iafw/59Puza849J
	 ejV2Jc3oml5RdYLL/pKusCMnLeVB9hg9qg6ZPYimIPjZGz3iF0IzdEmNYqv5YsE2m6ofC
	 /yNO1NndnSEiwuHAC7bCgAoQ9C42gZYbY0GDlt3SPyEIwQqYLMsGy4gTQrmIWP0IFi9/c
	 YxA+btvymg6KyAEM+peyZ3iz7450PhclqbhJCjwsAuj64xdDIbErNx262+7n26rAHtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QkYNVbFy;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4496A60A2603
	for <linux-rt-devel@lists.linux.dev>; Wed, 18 Nov 2026 14:27:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4496A60A2603
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QkYNVbFy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795012075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nZboGS9TzIUKYx8nlJm/8q9o+1lIrW0X9zgljbgU57g=;
	b=QkYNVbFysbtyTo4AxL9B0KwDuvSpfKKsbLodLqm+JE17yhpqM0Uc1uPV54vOxQ2dt2R8Mp
	DR5gWNMiUB1X7iZeh1X3GFSnqhRQITCHNkf1td9SMRIMjElUawN3/Z15TV4NKlFp/cpIEF
	H5TGVjuYC28MEq+4aildZ7y8A8b27uc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-W19d8ojEMMGhlGRFTjP3qg-1; Wed, 18 Nov 2026 09:27:54 -0500
X-MC-Unique: W19d8ojEMMGhlGRFTjP3qg-1
X-Mimecast-MFC-AGG-ID: W19d8ojEMMGhlGRFTjP3qg_1795012073
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48e4d1e29f3so1065693f8f.3
        for <linux-rt-devel@lists.linux.dev>; Wed, 18 Nov 2026 06:27:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795012073; x=1795616873;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nZboGS9TzIUKYx8nlJm/8q9o+1lIrW0X9zgljbgU57g=;
        b=VXFqsiRVVUx5TKHsTgy1TIYOXioVK0niFiaRvoR19/L+wafwauSuFJza9+wFcKQN+8
         cHWtVZeg1Xr53hxDNySut25CxkHCVNIirUbvMu+YyRQn33K5Skk1eVjUwiMUpFU/qKwF
         lU76s4zt6DsvkBf/jjY+sDmhouB0dbtPJTlQOkCm0+d78zrIVE2Nb4vXYQjAJqvhiWIt
         Sht/GV7mbFPHh6g3AB00TgaSxFPwa8fZVeElHc8JGB473Cnuj1MbarunY3evveev4P4e
         BgE8G7XS/B2uYQvkMLz1vYifs0MhUuBoPMfwWPZENyqToYfn6m/1Q7yLm7WSLHyR5kR9
         Ik/g==
X-Forwarded-Encrypted: i=1; AL+hErHi/mx4/pgoPERYY4Qi63M5xZUxm5h+8d9N3gdZ19sSs3w0pch5nCEHAWDHNr/YTPq4dMn5d8DulVoSV8lhDA==@lists.linux.dev
X-Gm-Message-State: APuU4Z/k32Vg55vDZnx1Gi3rrC6sVbXUPZgh7VZpbFEzmxtn/6VFxZBJ
	ANJ0uEkPiFL5Y8DSh9Ws+xnUxCYCEC/Qk42IS18/gSJmPK9Mfs3NUtclkxEF03YQG6EieglgZ/n
	MVNRe32A+6bw0u6QxwTbhK63p+0TDdY6MxIY7OmBO8GN+5ePoOMKgbqmJujiSTrdh4CS7
X-Gm-Gg: AZFdTZdESXlH2aimjzP/iQpXr2gCbrbu4Ph2L60siyhd0P1RIrVK9feNRalW+Z5gH05
	mw/kwNB/RDkbLQF6KxDaHn3OTgd88ApZYBTrNfIHlZS2SVZzwk7xIfG5MVkBLusNht4DkrHUCCU
	bqNZ03xea/MKFn/Kkx4ZbmKQolFwpCyl+T6z1KirZCV2usi+PRyiRzSiMQY55sXrRwNrAuuKHgA
	KO7OYJ/GlaJiN43aze/3C113jR1L0zohRkMhLIsLwb9tZyyop1adIonSOMoMN7I59ccPvOwZn0s
	XzwmUNQB8hGVa8Iln5+B6JB+42ycJaFCuilOZzjziYnFvu7xLljeizqEFQaKuVkNakNlm3uCSUd
	ac3vGK3DNeoGUghym5jcmFlHTMsqNb7rcIbzfqZbwV6bz9yWy4oUV6CAN7iJ2d08qR8P3LkI+Ul
	0g23w=
X-Received: by 2002:a5d:5888:0:b0:48d:ff71:dd87 with SMTP id ffacd0b85a97d-4a639475750mr5574833f8f.17.1795012072790;
        Wed, 18 Nov 2026 06:27:52 -0800 (PST)
X-Received: by 2002:a5d:5888:0:b0:48d:ff71:dd87 with SMTP id ffacd0b85a97d-4a639475750mr5574789f8f.17.1795012072412;
        Wed, 18 Nov 2026 06:27:52 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.158.90])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a656933961sm5275395f8f.46.2026.11.18.06.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 06:27:51 -0800 (PST)
Date: Wed, 18 Nov 2026 15:27:49 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
	linux-kernel@vger.kernel.org, tglx@kernel.org, will@kernel.org,
	boqun@kernel.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
	kprateek.nayak@amd.com, luca.abeni@santannapisa.it,
	mathieu.poirier@linaro.org, longman@redhat.com,
	ridong.chen@linux.dev, tj@kernel.org, hannes@cmpxchg.org,
	mkoutny@suse.com, shuah@kernel.org, bigeasy@linutronix.de,
	clrkwllms@kernel.org, parri.andrea@gmail.com,
	m.szyprowski@samsung.com, kayracizmeci@gmail.com,
	weihengqiuu@gmail.com, cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH v7 09/40] rtmutex: Continue the chain walk when a
 waiter's deadline donor changes
Message-ID: <av215SnBF5GShg0J@jlelli-thinkpadt14gen4.remote.csb>
References: <cover.1794922146.git.mathieu.desnoyers@efficios.com>
 <c8b228501d8981454f63843b394019fefd4002f3.1794922146.git.mathieu.desnoyers@efficios.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <c8b228501d8981454f63843b394019fefd4002f3.1794922146.git.mathieu.desnoyers@efficios.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: SKAVuaggJb0LoF5tx2br_t6-1vTNUy2R_JiSchQ2FVE_1795012073
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

On 17/11/26 09:10, Mathieu Desnoyers wrote:

...

> Fix this by recording the donor in the waiter with the sort keys, in
> waiter_update_prio(). rt_waiter_up_to_date() compares both. The walk and
> rt_mutex_adjust_pi() use it. A new donor then takes the walk on to the

...

>  kernel/locking/rtmutex.c        | 22 ++++++++++++++++++++--
>  kernel/locking/rtmutex_api.c    |  2 +-
>  kernel/locking/rtmutex_common.h |  3 +++
>  3 files changed, 24 insertions(+), 3 deletions(-)

Thanks for confirming the Sashiko finding and for the plan in your reply
[1]. As you note there, a window remains however the walk is changed,
because the donor pointer holds no reference on the donor. So I have to
wonder (and ask for Peter, Thomas, etc opinion) if we'd rather not keep
extending the chain walk for DEADLINE PI, which is known broken and
proxy execution is going to replace anyway, and leave rtmutex.c alone.

It looks like what we lack is memory safety, apart from accurate PI.
It's an hack after another, but how about having the owner pin its donor
instead: take a reference on the task behind dl.pi_se whenever it is set
to another task's entity, and drop it when pi_se changes
(rt_mutex_setprio() and __setscheduler_dl_pi() are the only writers).
The donor then stays allocated at most for the owner's critical section;
its parameters may be stale or cleared meanwhile, which
replenish_dl_entity() already copes with after patch 8; and the owner
may keep running on a stale donor, which is no worse than today's
DEADLINE PI. Thoughts?

Not against doing "the more right thing" of course. Just evaluating
alternatives.

Thanks,
Juri

[1] https://lore.kernel.org/all/f535fbbd-2247-4d0d-9771-a67116fda1a2@efficios.com/

