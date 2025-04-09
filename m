Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7DC265637
	for <linux-rt-devel@lists.linux.dev>; Wed,  9 Apr 2025 14:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744207364; cv=none; b=J6s+A40hm/K5rCpU2G70aoXH6zhwO7ynlk4HCQLFxrPm/n7+WNsdQJhezovOqwaOwPp82qPD7HfcwkbWCTyp8rGPV4qWy5yhY1LuezLabrNTknuALe2obhCKMiESNq1t1HS8IWRsTUPAWu+G9fBKY65zV5B/fS0pVuhq6p5CEbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744207364; c=relaxed/simple;
	bh=JRIrYSvIxXTm+pb4gvvJehPRD2NURTieCgUGjektsv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q+jUNuI66hdaVmikVwGG1fJTECL5p3w8x1PXbA8MtmLoqeJ8l0ejYEwrAhkFUMVDfiENAg+7Lgb8gWD4gmKLXG+y0qe9VzwgCeD4MJY46ec1x3zoJydsRxMF2L8z6lYjOp++3GoHM/Frf1s8BFGM0oNt6ZpzoQfwwO7dVGL7LEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bqEh5IAj; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bqEh5IAj"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3913d129c1aso597043f8f.0
        for <linux-rt-devel@lists.linux.dev>; Wed, 09 Apr 2025 07:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744207361; x=1744812161; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eWkSRo+s8E+NVFcYoRe4I5C9QjyjskzPyPuoXhbSgfo=;
        b=bqEh5IAjD1ogoJUJF9mKsRGwcDL5pKcWFXiaL/ONZ+YQ4o9TEl+DX3v+Pvuz9YE0Q2
         gPuYVA/EdW4WWtOjbn2TikCl4QbpnLwA1mF0gPgHWdnUNwkK69BWq94aYdfMX4f8qmO2
         13fcCo8hVX/jZ71KotehK9mFel456HfLkeCoFl3WH2otPkAM+ImYtBU9F1EEaBKj27KG
         IQKQTAmEwDKBQLudwZNeLjCF6ainlpf3H760psVA1OeXIrNDh4iyPciHndt/NJNqRVE6
         HR4oxiWxrlVS9yLoZwojvSTbGxJn0tA3dHmTxbxZnKNtBLk5QMkGqjkzrC/g5TLTgiKD
         AW7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744207361; x=1744812161;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eWkSRo+s8E+NVFcYoRe4I5C9QjyjskzPyPuoXhbSgfo=;
        b=XwRG+Qd+6YLWV7Bhn9Qk42arxNyTs8EhZr+74PQnyJlG+6RI6xf/pnulztUnvcX1Y/
         SXxDl8uqW2Bxh4KdJzHZLRfbUqa8QSbywD8pBBj7HmjPkHH/jx3pmhkktoeYZ3bCdnPM
         R0o/n5FPyUvCmNf9bl43ATgVWUvmQgRZqef8zZNmq0fy9DZ2WLHQjZ/J2xSBnF3LBsfm
         Dde5WpRkJZhWvxW28mkmnjAZVxlz2b5gs2ASJmdshhunn7ldiOScfoOhWNHCEdaHg/wp
         7rRqTQEZiNjy/U1UQ/eb7rsKTvtRUX6W22romhJ1Y9K86l3FedU+25h3OF4Q1nQxoTkP
         bIfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVT4NNddBXs3UyfH4cKX3/NghwEbiqYakyQbzDoRzULrVd9ub59z4v60VKLBYyIQy0RdYAhtDpKL2pkwRlPtQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxyd1ypTLmqWdybdc+EAZOBLCZJNFQ7MERZOh9NgJOjs1Orc3Fr
	QkT4HEu96LS5JQPmDCZxpFQTEMJZNkvW0zw9DfBuHTuCAxXqBjYt
X-Gm-Gg: ASbGncukYQ9+Obj/VaZ46mTj53KUWZ7L6LqjanaFPp1LgQ541Pjh0heOKo9/s5tAYU9
	OpQpTC9kZog+Hj+pSLdiCJZiei7ZMDN0udkINeTzM2joDvaXI0uHHb34bq2PG5IUyFwTq+WtLOg
	R9pyW0fLEdbEl2++1pacohWFXONBn2ag6ojIQcE4Q3j55GB3o9llm6OCzxVZf7o3p1scnxDfLlw
	n+LzOoOEgo/HWxnCGyuovV6pwC7W08Rr7rBFgbYhyvxmr9vMMT8ulBWyYv+Yn4cwP9fI/w0YzJq
	Oi0T+J+THhFUR2VzlZU6J4eCeZwwYf+PCooT6V2XbfKwl8Cn/H5e1W5j
X-Google-Smtp-Source: AGHT+IF049ubS5HdXQTc8n0xRJ+vhzdOB+ReFA0a6AeS7aGfjHRQyQyoNcgumkbEH6FOJaXvkv0ctw==
X-Received: by 2002:a05:6000:22c7:b0:39b:fa24:9523 with SMTP id ffacd0b85a97d-39d820acaf4mr6568070f8f.7.1744207359981;
        Wed, 09 Apr 2025 07:02:39 -0700 (PDT)
Received: from f (cst-prg-17-207.cust.vodafone.cz. [46.135.17.207])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f205ecb8dsm21327535e9.7.2025.04.09.07.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 07:02:39 -0700 (PDT)
Date: Wed, 9 Apr 2025 16:02:29 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Christian Brauner <brauner@kernel.org>, 
	Eric Chanudet <echanude@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Ian Kent <ikent@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	Alexander Larsson <alexl@redhat.com>, Lucas Karpinski <lkarpins@redhat.com>
Subject: Re: [PATCH v4] fs/namespace: defer RCU sync for MNT_DETACH umount
Message-ID: <4qyflnhrml2gvnvtguj5ee7ewrz3ejhgdb2lfihifzjscc5orh@6ah6qxppgk5n>
References: <20250408210350.749901-12-echanude@redhat.com>
 <20250409-egalisieren-halbbitter-23bc252d3a38@brauner>
 <20250409131444.9K2lwziT@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250409131444.9K2lwziT@linutronix.de>

On Wed, Apr 09, 2025 at 03:14:44PM +0200, Sebastian Andrzej Siewior wrote:
> One question: Do we need this lazy/ MNT_DETACH case? Couldn't we handle
> them all via queue_rcu_work()?
> If so, couldn't we have make deferred_free_mounts global and have two
> release_list, say release_list and release_list_next_gp? The first one
> will be used if queue_rcu_work() returns true, otherwise the second.
> Then once defer_free_mounts() is done and release_list_next_gp not
> empty, it would move release_list_next_gp -> release_list and invoke
> queue_rcu_work().
> This would avoid the kmalloc, synchronize_rcu_expedited() and the
> special-sauce.
> 

To my understanding it was preferred for non-lazy unmount consumers to
wait until the mntput before returning.

That aside if I understood your approach it would de facto serialize all
of these?

As in with the posted patches you can have different worker threads
progress in parallel as they all get a private list to iterate.

With your proposal only one can do any work.

One has to assume with sufficient mount/unmount traffic this can
eventually get into trouble.
