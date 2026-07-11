Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942E43BBFB3
	for <linux-rt-devel@lists.linux.dev>; Sat, 11 Jul 2026 12:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783772002; cv=pass; b=Tdkh2KaZjsLxSFfZNSNn39mbfKwNvXVI7Qhy+3jzJ0P5fgzovyntq/b1Q2QHI9+Nxo+bhvHZBdojqfxc7k5baic8gRAzYVVEoM1mbrmRjMS2VRN61McyTXeHVVTOb7EErbpLReOEH9IoA93JOEQiV9lox7MZUWabOJ4bfBoqMg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783772002; c=relaxed/simple;
	bh=80vo3JIjnCsKn8zo158HX4vkfRXd32w7uPzzJAtLaF0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mJL3tUWJZqdSTatxQvRa9wnGj4qGAaSeLqV0Sr+3TCI41VIGu4P3JFJIkHTBowtaMP8AFbUlgUNWlGDhIV8NDfLHK6yoEDNdguStTElctuDizPGt6c0LRYnZE+dfzdek9L+2qo/yGHM2xEGOCGZcXJu38UAHhWc09mw/f52buTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TyFVr4S4; arc=pass smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TyFVr4S4"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3856d4015e0so265660a91.2
        for <linux-rt-devel@lists.linux.dev>; Sat, 11 Jul 2026 05:13:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783771999; cv=none;
        d=google.com; s=arc-20260327;
        b=kxwCPn6yunbi5AI/OeR2yqlPiNGybN+CFvyvAr1TSNhefkLiWiZRK5DMWdEdewlNkf
         f1m7S319UhnSJLFXgxOl4cMtn20Q3BfoPGlfvZmWa4VNC/IJYiJ+YNHo5UDs73u6NBDX
         SiFIKzQSEsEbmo92IggGOSyDWvJgHVUN7GTJ2jCHcHV9hHRds5WnPJxsfGQwEBMVmKTD
         QB4WKorkbrt2/p/ciBKqqevsJAsW1spFraSWtBoIsShRpAU0qVvGKMRjtPNuQ60mVr4a
         yKA4Afgodgmpbh5KVDsTDvtvYgh4CIRxT7iOYJOtqC4Ay7bA9GsgmeOkqoVxv4CjaJic
         f9ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=80vo3JIjnCsKn8zo158HX4vkfRXd32w7uPzzJAtLaF0=;
        fh=+1gEGQg6vVlpVGf7oQZCsC2uWhRhn6fsgdxPHPtf0/Y=;
        b=EhDbIX/IOmBa0u4oPbhTCbgHwvLA2/SXZHEWScbqZkgnfdAnyAuhexvEqCzIRRywZx
         xCjCKUtHF0Lz7qXgNUqIAKFVjaTH25ILOZPfXWdd6BPg/Oo1MeMnaA2dWSdpZJPd5y71
         15Hi4oZdWO+lL4iGoEE5vveF2uNk+jaUh7nm0JGSVT7j7JB6GGP0JUd/uSOn7LQ9ZZ1J
         3bHMlrKGEysFh+Z27942BdOdPGNtTvQROG4F3saDreNML7S8urW8XozhrBL0/gVoHkxk
         kOeKkcCLsPZdGSGWDIiKVjd3ZJQpGX7Pbs8JtPY+avlv90t8fBt1xxCHr2fSEOh8jWJf
         q3hg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783771999; x=1784376799; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=80vo3JIjnCsKn8zo158HX4vkfRXd32w7uPzzJAtLaF0=;
        b=TyFVr4S42kzhOKuT/O9IR8P0iQ9r5FtT4VJISnbFcOkk5iWnxpjZVB7KpDRU8Kfl7l
         PkDVcPo8a2qlsf2cHXuj3wi9kuy/fWK7GD9S13JpxR47SFYWG6J0mx+xxe+/gvW5qY8a
         whi2Pfj61sKLQCr+3hvwGsK7cwewHd3zhy3CF1fBDHK56uLkp6s6WTAxxZs8GMZfF1PV
         gZ1O/jCR2C9E8unxEXK8R0JQ13RkFUy/8kp8JGC1SQUOOaPXOvM2tdFsmCho+QK4WVxn
         XrLHZYz2yDVVlb/WcDs605l/MakBQu9+WKahII7aTdc7fh/5fQbpKJziMtxiuc6x+nOE
         8n+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783771999; x=1784376799;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=80vo3JIjnCsKn8zo158HX4vkfRXd32w7uPzzJAtLaF0=;
        b=c+8qxSem0aBnI0rExojObwvft8S0s+/cNWrKAlXfNQjIqiEiat4Zhs+gmB3DYUrDCR
         wmmFuYiQ8p7YgXWwUZBUpGwWGmjSELK7igWNkAMk30J6bi/zotla3gboJLjHX9cJrnp/
         B6LuQHr+Tzis8ja8dPH8yGId3BSJ/AcSy9iWpJ0lqOTWZJStqnKII5Ga+T/0y/i4uggw
         vRqMgKbEEnU8HHKcsq4W3ewlawYspbVnJdo15GoIRFB5ymg3c0YmLwzmc25y6RdivjLM
         KY3px7MJdlQpA5JnPD2/C1pqlVHsZEtHIMSIhH1tgj+74ZqvEk+QVEaZW9XYgMQBhu7i
         eD5w==
X-Forwarded-Encrypted: i=1; AHgh+RoO3l0feHCJkcQ99TpGaVz43tthdZRNAR50ODX9JTGOTUTcqCVuFRIBVGFLe9X85uDpyhLq0xAyC+/mA7XlcA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzQJheVlfDmz+9zqzEEDKv/XmVL1YmEGUC03BE4ZPh/ggUDbIQ3
	0Kand4hF1bfh48Bp3NMquOfEkJH0njSJ8BOEFRdamyqDuj9Ab2x5kn8UDEZAznwww3x1Z0918Vh
	2rkKuOQz1ZojaojaO3NtkoT0vIPyc5HE=
X-Gm-Gg: AfdE7cnXLQz764v+KQYwFWdyKX58xJM+Ii4fT2EUXI6oKYvaERCIOBcUwmBmU4wtpU9
	mLxOqvLN4RJ0y5qvzb/HvFk3VuKf6FUEZL6a9vZHe+Y6m1XOfOgnSMXwQYXj2njhArzB6zWsPyh
	gT2p1v7/l+N7CsEEmeYBIOA0sokGa1Uk14J62+qvOQbBKeLiTBp8HzDy9p8lNf2csgWaWcFaCZ4
	9BPSbU90l4gk05RjVmSWMXkJacEXQ++wZ9suzX1K5dXO/E77THNJNXaGXIjfu9n2LpaqRfMUZ/0
	9eXeXd9PzT2L+IZWauh7EnPXofIYiJiMpXi5BZTgxb62SQJNyris/qtc+IQG6/9PR2fpvbpdy3k
	zjeDveAH88tfc
X-Received: by 2002:a17:90b:4984:b0:380:9cd1:d985 with SMTP id
 98e67ed59e1d1-38dc7c111a8mr1909664a91.6.1783771998816; Sat, 11 Jul 2026
 05:13:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260706061928.66713-1-byungchul@sk.com> <20260706061928.66713-40-byungchul@sk.com>
In-Reply-To: <20260706061928.66713-40-byungchul@sk.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 11 Jul 2026 14:13:05 +0200
X-Gm-Features: AUfX_mwWK6GqFCLIKCx9ivosmcno3i0b64L6R15FyNFXSSwj0HKdZlNefQKWcgc
Message-ID: <CANiq72kEo=bGcHNaSA9JZhv4iuE+YDvu0kN+Z7aopVp3=2C+Wg@mail.gmail.com>
Subject: Re: [PATCH v19 39/40] rust: completion: Add __rust_helper to rust_helper_wait_for_completion()
To: Byungchul Park <byungchul@sk.com>, Gary Guo <gary@garyguo.net>
Cc: linux-kernel@vger.kernel.org, max.byungchul.park@gmail.com, 
	kernel_team@skhynix.com, torvalds@linux-foundation.org, 
	damien.lemoal@opensource.wdc.com, linux-ide@vger.kernel.org, 
	adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, mingo@redhat.com, 
	peterz@infradead.org, will@kernel.org, tglx@linutronix.de, 
	rostedt@goodmis.org, joel@joelfernandes.org, sashal@kernel.org, 
	daniel.vetter@ffwll.ch, duyuyang@gmail.com, johannes.berg@intel.com, 
	tj@kernel.org, tytso@mit.edu, willy@infradead.org, david@fromorbit.com, 
	amir73il@gmail.com, gregkh@linuxfoundation.org, kernel-team@lge.com, 
	linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org, 
	minchan@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com, sj@kernel.org, 
	jglisse@redhat.com, dennis@kernel.org, cl@linux.com, penberg@kernel.org, 
	rientjes@google.com, vbabka@suse.cz, ngupta@vflare.org, 
	linux-block@vger.kernel.org, josef@toxicpanda.com, 
	linux-fsdevel@vger.kernel.org, jack@suse.cz, jlayton@kernel.org, 
	dan.j.williams@intel.com, hch@infradead.org, djwong@kernel.org, 
	dri-devel@lists.freedesktop.org, rodrigosiqueiramelo@gmail.com, 
	melissa.srw@gmail.com, hamohammed.sa@gmail.com, harry.yoo@oracle.com, 
	chris.p.wilson@intel.com, gwan-gyeong.mun@intel.com, boqun.feng@gmail.com, 
	longman@redhat.com, yunseong.kim@ericsson.com, ysk@kzalloc.com, 
	yeoreum.yun@arm.com, netdev@vger.kernel.org, matthew.brost@intel.com, 
	her0gyugyu@gmail.com, corbet@lwn.net, catalin.marinas@arm.com, bp@alien8.de, 
	x86@kernel.org, hpa@zytor.com, luto@kernel.org, sumit.semwal@linaro.org, 
	gustavo@padovan.org, christian.koenig@amd.com, andi.shyti@kernel.org, 
	arnd@arndb.de, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, 
	rppt@kernel.org, surenb@google.com, mcgrof@kernel.org, petr.pavlu@suse.com, 
	da.gomez@kernel.org, samitolvanen@google.com, paulmck@kernel.org, 
	frederic@kernel.org, neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com, 
	josh@joshtriplett.org, urezki@gmail.com, mathieu.desnoyers@efficios.com, 
	jiangshanlai@gmail.com, qiang.zhang@linux.dev, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, chuck.lever@oracle.com, neil@brown.name, 
	okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com, trondmy@kernel.org, 
	anna@kernel.org, kees@kernel.org, bigeasy@linutronix.de, clrkwllms@kernel.org, 
	mark.rutland@arm.com, ada.coupriediaz@arm.com, kristina.martsenko@arm.com, 
	wangkefeng.wang@huawei.com, broonie@kernel.org, kevin.brodsky@arm.com, 
	dwmw@amazon.co.uk, shakeel.butt@linux.dev, ast@kernel.org, ziy@nvidia.com, 
	yuzhao@google.com, baolin.wang@linux.alibaba.com, usamaarif642@gmail.com, 
	joel.granados@kernel.org, richard.weiyang@gmail.com, geert+renesas@glider.be, 
	tim.c.chen@linux.intel.com, linux@treblig.org, 
	alexander.shishkin@linux.intel.com, lillian@star-ark.net, 
	chenhuacai@kernel.org, francesco@valla.it, guoweikang.kernel@gmail.com, 
	link@vivo.com, jpoimboe@kernel.org, masahiroy@kernel.org, brauner@kernel.org, 
	thomas.weissschuh@linutronix.de, oleg@redhat.com, mjguzik@gmail.com, 
	andrii@kernel.org, wangfushuai@baidu.com, linux-doc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org, 
	linaro-mm-sig@lists.linaro.org, linux-i2c@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
	rcu@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, 2407018371@qq.com, dakr@kernel.org, 
	neilb@ownmail.net, bagasdotme@gmail.com, wsa+renesas@sang-engineering.com, 
	dave.hansen@intel.com, geert@linux-m68k.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, bjorn3_gh@protonmail.com, lossin@kernel.org, 
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 6, 2026 at 8:22=E2=80=AFAM Byungchul Park <byungchul@sk.com> wr=
ote:
>
> This is needed to inline these helpers into Rust code, which is required
> for DEPT to play with wait_for_completion().
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>

Apart from what Gary said -- why did you need to do this in a separate
patch in the same series?

Cheers,
Miguel
