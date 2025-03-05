Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6981519A7
	for <linux-rt-devel@lists.linux.dev>; Wed,  5 Mar 2025 02:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741143286; cv=none; b=Xoq90XocDNkm+0bEdIjFiYJ3cWMIH9g3uaAsLCwmpyCSkgq2YEPRzUvKBta6tjO0rSz2H556uVV9UEHcaT3IhIWRHP+KXXVJf0g9QsNYljjQSrUQ8t6PfmEU6u3YWllB40cGcoDYAMDA6/BZ8C0pYmgnTvCtLWqBM8h1kdImBCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741143286; c=relaxed/simple;
	bh=UV6gyGazzJ42NubyrUwHa0PU0qVcgVll114FV7ifGlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m4JGZeRuMS3MBCqkbhs5miHWJVSniAA/oabzDr0jbRe+FwlGC57CPdxNJBlsoRUlPOdQM6uyPxTIXp+e5eczpaZpSldgqlDUgjlidcyj3Jno0hMTSsNWRv6kY0h0kj5PrFSZjkOZEmtszOSr56f71E+AHTxoyHvNATRF82g17ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IuqCQcP7; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IuqCQcP7"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c081915cf3so823174985a.1
        for <linux-rt-devel@lists.linux.dev>; Tue, 04 Mar 2025 18:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741143283; x=1741748083; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UV6gyGazzJ42NubyrUwHa0PU0qVcgVll114FV7ifGlA=;
        b=IuqCQcP71f20glU97OV2XeKtqmo09n1ZVjsFkWOogflZDjyBQ/drsjIEi3c56SYm78
         XcvpOcVq123uO7BwOtYgQUQdojKX5I/NVCRUTiNbN1RrcwqHmn2TVMYixMrvuklEsqQH
         e9DrY/pP/QF/W/TUEgF9MmUvQ3tJx/kl4FrmY4TvY5Uq0FZL+X0DY7kW+Fwu8tuIDkdy
         uH4DLU6nnpgzNBrfWQMEY1FBFqytRh978H4V3kmi29tVcywO95wOmQwi0vD2ltfZXUTU
         crQHQBuf1DaFAH8ijLDdzqz6VsfI9evcGoLhi9OSCDqYgdF7D1q6s+DKs4turUPTxw23
         WsIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741143283; x=1741748083;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UV6gyGazzJ42NubyrUwHa0PU0qVcgVll114FV7ifGlA=;
        b=h24zAiMqxD1LUS4T0t8QSBmLIJUnWDG9ketnyiZekAqKV+s/KKvsgMF3nRxx7Go02H
         nzBuk2i2Wbn4QD3b/D9PJJCcYu01XLv/mb9p70O11fNnWVJB7UXyZU7uYeNE0emgtImW
         KT5sDDJelHLR3WDrklz5ksmWJzD3zfamC61nP7IsgbozL4mgIQRGP15QIbrBsYzN+bs+
         k5KnRQF5xe6O85XmEBzLrlHjgEQMhPb3vXpXMU+/1E5mZhKv+4KFTgfBo47/eusMq4r1
         ZbUKAaucwL/D5xYQfHI+I9QFI8xL1tNs7iEuPafaB9i1PadMhZvN9HnMs7AUdz1gigZl
         g1Rw==
X-Forwarded-Encrypted: i=1; AJvYcCW7TzSAggnrDp7+5JMTvcOE86aZnwpNyDGj/Hs5zWzUNUlx9sD4ZV13ZW2TTUGvnUXgIRVNHKAOWNPe113v2w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzkx1GQwwQfZEsr2Qb6QJhE2ym9niv+38hoDdqC7+ziNWV3p3sE
	9HYOCR8WCETJ1hlS5dDWDgzKJ8Ayw/8fCqNbmT8Q1zKRQC+KNwjX
X-Gm-Gg: ASbGnctA4kvzOkVNEyNld9TAoKXiZcQ/V9sSISRyQKjRR7e/r1OyW3BWxQyVJqZwHI9
	/VoyivbDHBv+j0ibNewEsMbBUnvjaQQb345yYLLSZRpAE2NpON1+VDAcOIDmKFYgu/l7rQNcN85
	vmHhbFVjG5p5Vs+RDiS0pSNl1w/evjDT1Oxe0DpOyt37rW52IKxSX2NWtZvEPzbKkw8/Nt9uUCf
	PCkf9ulDq6QdlZ+7QsQLHSVLaP9paJtbdiG9HnbAXUK/x5UwrM6Nqx227w8LiDttyM4b5DiBtqB
	ja1GAXC0MnlqLQ0T3gX8pYvQZBYZs6+dY+kKotCzRj+dQV4NOYGBaTff36LCySNU2LktxuORACl
	z5c/j3VsThjPsc1jyfUBM9b3JRNP1Z9iNh7k=
X-Google-Smtp-Source: AGHT+IHBoQiW7YLCUvoHR0BGtgdkr30Lh1JWx2qiZpsHE/51TJNn1Bw7Jeixsoev4iKBvUmgHnx5uQ==
X-Received: by 2002:a05:620a:2607:b0:7c2:40d1:8593 with SMTP id af79cd13be357-7c3d8e20ee3mr236316985a.3.1741143282793;
        Tue, 04 Mar 2025 18:54:42 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3ca43ad81sm228200185a.80.2025.03.04.18.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 18:54:42 -0800 (PST)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 71EED1200068;
	Tue,  4 Mar 2025 21:54:41 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 04 Mar 2025 21:54:41 -0500
X-ME-Sender: <xms:8bzHZ9LFSO-a7ihBB_pv8V5rMhqrCR_uO6brALv_DTsMkbnINqpj9w>
    <xme:8bzHZ5ICRQVksAlERae5OZAvduwZlz1qAgrERq5bNKjTQt0f2uYUbcUpoMigZ3QGd
    UpwwI3GC1dXsBLtQA>
X-ME-Received: <xmr:8bzHZ1ucqTCiCh6UQ1HAcC2SWKqx4g4_vR06lzjQbgjSp2dCVHYOF0BiRw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdefjedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtqhfstddt
    tddvnecuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrg
    hilhdrtghomheqnecuggftrfgrthhtvghrnhepheeufeduuefftdevffffhfehudeitdff
    uedvveegleffudetueegvdehtdfhlefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhn
    rghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpe
    epghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopeeftddp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhhoshhtvgguthesghhoohgumhhish
    drohhrghdprhgtphhtthhopehrtghusehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepphgruhhlmhgtkheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfhhrvgguvg
    hrihgtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvggvrhgrjhdruhhprgguhhih
    rgihsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohgvlhesjhhovghlfhgvrhhnrg
    hnuggvshdrohhrghdprhgtphhtthhopehjohhshhesjhhoshhhthhrihhplhgvthhtrdho
    rhhgpdhrtghpthhtohepuhhrvgiikhhisehgmhgrihhlrdgtohhmpdhrtghpthhtohepmh
    grthhhihgvuhdruggvshhnohihvghrshesvghffhhitghiohhsrdgtohhm
X-ME-Proxy: <xmx:8bzHZ-bAeG0ZN1GRSTXMehPu8GzSaSPV29guxqRdGz2fwFl_WYKV5Q>
    <xmx:8bzHZ0aKBJ5-5VFBHCz5DMRPMteMbfFZAPBaND6ZAQN2X7WHkXQD7Q>
    <xmx:8bzHZyBgmAnxKIcGNuSZ5RxojsTbDVVWDzKB6k-raS6dr88qNYe3dQ>
    <xmx:8bzHZyY_W8yOb5yK3MJYbCUbBXmGtxXxETMRJS4EIEmVEcYWau52eQ>
    <xmx:8bzHZwrUTjFR0__3g6VW5Q28j-I-8Okx3u1SPTqqw8wuH5BuD7BoXgjr>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Mar 2025 21:54:40 -0500 (EST)
Date: Tue, 4 Mar 2025 18:54:38 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: rcu@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
 	Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 	Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>,
 	Uladzislau Rezki <urezki@gmail.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 	Lai Jiangshan <jiangshanlai@gmail.com>,
 Zqiang <qiang.zhang1211@gmail.com>, 	Davidlohr Bueso <dave@stgolabs.net>,
 Ingo Molnar <mingo@redhat.com>, 	Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 	Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 	Valentin Schneider <vschneid@redhat.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, 	Shuah Khan <shuah@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 	Clark Williams <clrkwllms@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, 	linux-kselftest@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, 	Ankur Arora <ankur.a.arora@oracle.com>
Subject: Re: [PATCH rcu 06/11] osnoise: provide quiescent states
Message-ID: <hrwgh7fevnkmkaizc7226kyywgzi22efmtnepzwah7ticrozbv@lcg23v6j7p7g>
References: <20250225035516.26443-1-boqun.feng@gmail.com>
 <20250225035516.26443-7-boqun.feng@gmail.com>
 <20250304142127.391ca6bd@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250304142127.391ca6bd@gandalf.local.home>

On Tue, Mar 04, 2025 at 02:21:27PM -0500, Steven Rostedt wrote:
> On Mon, 24 Feb 2025 19:55:11 -0800
> Boqun Feng <boqun.feng@gmail.com> wrote:
>=20
> > From: Ankur Arora <ankur.a.arora@oracle.com>
> >=20
> > To reduce RCU noise for nohz_full configurations, osnoise depends
> > on cond_resched() providing quiescent states for PREEMPT_RCU=3Dn
> > configurations. For PREEMPT_RCU=3Dy configurations -- where
> > cond_resched() is a stub -- we do this by directly calling
> > rcu_momentary_eqs().
> >=20
> > With (PREEMPT_LAZY=3Dy, PREEMPT_DYNAMIC=3Dn), however, we have a
> > configuration with (PREEMPTION=3Dy, PREEMPT_RCU=3Dn) where neither
> > of the above can help.
> >=20
> > Handle that by providing an explicit quiescent state here for all
> > configurations.
> >=20
> > As mentioned above this is not needed for non-stubbed cond_resched(),
> > but, providing a quiescent state here just pulls in one that a future
> > cond_resched() would provide, so doesn't cause any extra work for
> > this configuration.
> >=20
> > Cc: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
>=20
> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
>=20

Applied, thanks!

Regards,
Boqun

> -- Steve
>=20
> > Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> > Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>
> > Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> > Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > ---
