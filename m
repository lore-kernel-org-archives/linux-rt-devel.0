Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DFD2EE99C
	for <linux-rt-devel@lists.linux.dev>; Wed, 18 Jun 2025 17:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750267305; cv=none; b=CNL5jr2gvHDTIBfhKCxCC8sNrHEa9iXdJVRRU3PqBzlAQqfwZYDOaXB88IvWRnD81kXHJaBSw7hBfWbNnWQGZLziE5YnmRMIvDcYEE+fdSY1Re5coiegsJPsBhylHMdpxlNMy40j1pVxgjGA+VrKa5drqBSVkIxVWYokMikx2Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750267305; c=relaxed/simple;
	bh=FkWozodUKen40StoXQS1uyQvcdO2JECfQGlSZypGNZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gghwq1RnD9hs0uetGO/q2JVgbO5FWnZyxzxOYMZUM3KdVPiKY5hvpDg3LNJ/CkVu6L6UJzgWPxrG0chy5usvFA2LJ2XJeYjvQm067Sh/KGrhGjdN+5yGszqfM7lEyczetvKlDLxo6+skDEhom0M6jC9WmzuoFhJrlTihM0Bje2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QnQAEv5v; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QnQAEv5v"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6fafd3cc8f9so94910316d6.3
        for <linux-rt-devel@lists.linux.dev>; Wed, 18 Jun 2025 10:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750267302; x=1750872102; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k0u+i+peyVQga0VUutMCyFjioDjdoFJwmIZs7VrpQUg=;
        b=QnQAEv5vT//QLyIeJhNnDbgti179yHeUrrfRsIimgkjjOMlFv5aetHMBOiCwTnkPvb
         4YHwu95hErjYjkER3PTvMY++gBy+AJmnsQWiYthubHdcWfzp5CL+rjX34He0oe/Sa7xh
         Z9GSW9+lOdelAc/KIepmEN1u7xM9chOEvPjtJtB1+spnz9/VkQke85VHzejZ2fDiRj3c
         1UOc6G8IZ2uJb92wk5nkJwG6+qR4QfltcowKheFB2EtW4xIRPjUqaMV5DLo/dgvWZNOX
         Zl5Iqfio8JYURJaujIHY0Jt9p7IDbC2liYnXW8aXXBBp2eI5tYWaQS2SpkoVSkVyWSxo
         MnFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750267302; x=1750872102;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k0u+i+peyVQga0VUutMCyFjioDjdoFJwmIZs7VrpQUg=;
        b=XEmPb/a1vOp252dhNat1psK1/xVTPG2W3igZUkLh3GhLo06CuZHh/HiffpE11HVmz1
         DyF9rOo7tzMk2wL2xYdRLHS7YXEnS/c3L2txAQUPD1Ou9uSOphPnen9FqwYsggvGmuOd
         hkq5FjVGcsgF9+mc/GrS59cTW5WoXDbsAahjuGU9jGdkI+BATgb1m4AkwHRq/1E7Hg7w
         N6HbB4gEnX5nXtBm4F3APn/GQKQAbcddpc9RXNKynWfoIOOuPtQaiNtLTbzonKg3vbv2
         Yvhl/R9Hz9sy10iGgMRbajQFFIlRUFZyl0Ox7pVHRxQXCjGdzsjYVtR+WqRTBYJHStn5
         /2kw==
X-Gm-Message-State: AOJu0Yz7nl8AmhI34ACXnm0o5FpXupOYkouedZ5UXQDDvd5oqGrIYh9+
	ihm+mklS6/6MaQF81O+6E8Ykilk+NihUTFl4SD6up4DAA0iRNyBAEQET
X-Gm-Gg: ASbGnct0vI0C5nbf/eUdL5weSV041oAqrAEytAabpPu1MaduCw3l1RLPvgGvmVqGNEN
	8Tvf5ZNLt20/X949rQdEivzNSOLZgsK5DwQSgjduZ8FJWbSog75y8uVXzMZm0CCiP++jm3QuMpd
	ZOx4hl5tEIentoF13MtIrcKnmx7X5d9zSvs9eUdkrGm0lkjmeD62I/4j3vCoeEpVdApVERz7ON4
	OXkzmXiXdANy6hb/YucZ7HyLvIUungyMWqIaDCXkFlbiwWIKD7phLKyVwc9uG7lF/kxQS3zymNx
	CpfCCoeBC6o6bsahWiVbS3mANnx//CTr179h1+DwwxaxIkbIKnQ7ex9blXi5QQq+N/7rFrA0I9b
	ARSQ3r4kYTVjj2ffF1iWWWN60SjNd364pix6L7STJgHlTW2SJEfB51/3TGHBnov4=
X-Google-Smtp-Source: AGHT+IGMkqZ89ihj8ugCuPYfIGdOfyar11u68nXEwEXSKQEgU9BnoCP9kqRwqbrvC2a/GH3iDHpoOQ==
X-Received: by 2002:a05:6214:2527:b0:6fa:c054:1628 with SMTP id 6a1803df08f44-6fb477d995fmr296774456d6.23.1750267302291;
        Wed, 18 Jun 2025 10:21:42 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb35c55ff4sm74731226d6.92.2025.06.18.10.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 10:21:41 -0700 (PDT)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 717E41200043;
	Wed, 18 Jun 2025 13:21:41 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 18 Jun 2025 13:21:41 -0400
X-ME-Sender: <xms:pfVSaAw4X12WcYUMSJe7e4uOeSOpRVNzeeqDtPrQprrTseQ7U-QzAw>
    <xme:pfVSaETB66gPgWNezDZbL-3GnUO3IxPlHsCXAWAJbGPPj14UGEAzElBQmP9gm8dlj
    7_vbP3iYQPQJIbLYQ>
X-ME-Received: <xmr:pfVSaCW6FNZMl2SkPsmLG37JGibqWdXE2klFIJkc3Piqo2QKTbGuFcLY_z1xQA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdefvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleei
    vedtgeeuhfegueevieduffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhi
    thihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmh
    grihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepudejpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegsihhgvggrshihsehlihhnuhhtrhhonhhigi
    druggvpdhrtghpthhtoheplhhinhhugidqrhhtqdguvghvvghlsehlihhsthhsrdhlihhn
    uhigrdguvghvpdhrtghpthhtoheprhgtuhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlihhnuhigqdhtrhgrtggvqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehprghulhhmtghksehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehfrhgvuggvrhhitgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhovghl
    rghgnhgvlhhfsehnvhhiughirgdrtghomhdprhgtphhtthhopehjohhshhesjhhoshhhth
    hrihhplhgvthhtrdhorhhgpdhrtghpthhtohepjhhirghnghhshhgrnhhlrghisehgmhgr
    ihhlrdgtohhm
X-ME-Proxy: <xmx:pfVSaOjrD7t8ihquIN_wdaBaQ_pQy09DADhtsqpE9A2AsUB5KTqneQ>
    <xmx:pfVSaCCm3dnKo6sHwvLx3UpPOLkUfFlk068b0ZN9N0LcQ_ezYYmdbQ>
    <xmx:pfVSaPIXB02zpSRAI-h5AzKWHMQHko_N_QKvp4yrsiKv5HGs1NFjOg>
    <xmx:pfVSaJAvPo32qj6ssNo0y1_T9wlCm5fbJHKGe2iI-EY61DNBhpfdGg>
    <xmx:pfVSaCxtpsN63EVstI6VOCPUQ2-JdQzRw-foJJ255sG5J1OwZAPmh1gA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Jun 2025 13:21:40 -0400 (EDT)
Date: Wed, 18 Jun 2025 10:21:40 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-rt-devel@lists.linux.dev, rcu@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>, Zqiang <qiang.zhang@linux.dev>
Subject: Re: [RFC PATCH 1/2] rcu: Add rcu_read_lock_notrace()
Message-ID: <aFL1pIGMDX5DG9f_@tardis.local>
References: <20250613152218.1924093-1-bigeasy@linutronix.de>
 <20250613152218.1924093-2-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613152218.1924093-2-bigeasy@linutronix.de>

On Fri, Jun 13, 2025 at 05:22:17PM +0200, Sebastian Andrzej Siewior wrote:
> rcu_read_lock_notrace() follows preempt_disable_notrace(). The idea is
> provide a rcu_read_lock() version so that the preempt_disable_notrace()
> user (which use RCU-sched under the hood) can migrate to preemptible
> RCU.
> The first user should be tracing (tracepoint) which is using the
> _notrace variant.
> 
> rcu_read_lock_notrace() is a slim version of rcu_read_lock(). It simply
> increments/ decrements the counter. It does not emit any warnings if
> RCU_NEST_PMAX is exceeded or patricipates in STRICT_GRACE_PERIOD. It
> also does not participate in rcu_read_unlock_special() as it would if
> invoke from NMI.
> 

If it doesn't participate in rcu_read_unlock_special() then it may not
report a QS in time, right? For example:

	CPU 2			CPU 3
	=====
	rcu_read_lock_notrace();
				synchronize_rcu();
				// need all CPUs report a QS.
	rcu_read_unlock_notrace();
	// no rcu_read_unlock_special() so QS will only be reported next
	// time we if another RCU read-side critical section exits.

Wouldn't this be a problem?

Regards,
Boqun

> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
[...]
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 0b0f56f6abc85..02cccca917a22 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -420,6 +420,13 @@ void __rcu_read_lock(void)
>  }
>  EXPORT_SYMBOL_GPL(__rcu_read_lock);
>  
> +notrace void __rcu_read_lock_notrace(void)
> +{
> +	rcu_preempt_read_enter();
> +	barrier();  /* critical section after entry code. */
> +}
> +EXPORT_SYMBOL_GPL(__rcu_read_lock_notrace);
> +
>  /*
>   * Preemptible RCU implementation for rcu_read_unlock().
>   * Decrement ->rcu_read_lock_nesting.  If the result is zero (outermost
> @@ -445,6 +452,13 @@ void __rcu_read_unlock(void)
>  }
>  EXPORT_SYMBOL_GPL(__rcu_read_unlock);
>  
> +notrace void __rcu_read_unlock_notrace(void)
> +{
> +	barrier();  // critical section before exit code.
> +	rcu_preempt_read_exit();
> +}
> +EXPORT_SYMBOL_GPL(__rcu_read_unlock_notrace);
> +
>  /*
>   * Advance a ->blkd_tasks-list pointer to the next entry, instead
>   * returning NULL if at the end of the list.
> -- 
> 2.49.0
> 
> 
