Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6721F1932
	for <linux-rt-devel@lists.linux.dev>; Fri, 24 Oct 2025 23:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761350253; cv=none; b=U0cdjVhgPW8g78RzXdrnuC9yjNPoC/Ho0dBTY4w2cJKaiN/jaajsFADp1jZ3WDtJ0RWBF3jiyQKrv07oIWNO9o+awqpJ4LQkNado98/+ICK0vm4aDfReYSFW5pNtsu4lmIggSi2ygq8GFvt9qLvJyhMnjrWf8/O8Tdzxc66TL5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761350253; c=relaxed/simple;
	bh=dNKLlMrwd1/HZexcmyJUATq+vFaKLMO+fNIoDoZR3Os=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rFx7DfcEGC1c8ga9Y/O4IlZObgNsvAdDFz94exujdVm4msX+VipqP7aKR1/WLIs0QZLv1N4PFwU1bAGeeW92X81FDD4vbh1mWyKlElu98/LHYixTT4bh0wVZr+8qml1G/52qIopRN8xse46d6vgCkJFHApvY5Q70443TG07Iiw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ENZVLu4D; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ENZVLu4D"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-475dc6029b6so1988685e9.0
        for <linux-rt-devel@lists.linux.dev>; Fri, 24 Oct 2025 16:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761350250; x=1761955050; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dNKLlMrwd1/HZexcmyJUATq+vFaKLMO+fNIoDoZR3Os=;
        b=ENZVLu4DnEX5xCo7wBff7tU24OAGXhuLZlWfubGnqSBR3JX7kft+N3J0sQEgGgbOvO
         H3aNpdkoHAv+Ys82MUyOiTn4Mm4RJKUJoyLOPTbt35QYZHl7GpV7G+jXFswaDA1Aqny9
         YFhqxzoLuiqsLbOpxGUqaHQREGMCAAODmARJ9ru3axQOekBLgZZmF3m49Ycu44gZAyXf
         CgnG7Qo3m40xxlnzpR7KYNSKqgG39V7Q87fpkt3jpGP+/xJUb9du+9zttZzeRVBUdK2w
         /pK0bhpnh0Yyb0YUzl9LEniSYu9ihBo6g0b1CAmVoE5HK2kVTILTNYEgf7ud1CZGs0RJ
         LDzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761350250; x=1761955050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dNKLlMrwd1/HZexcmyJUATq+vFaKLMO+fNIoDoZR3Os=;
        b=HLyk7QxbEC+/oWB2iup5CStk8CMJv+Gp13I7FraYPfYx9Qj1qPm7fcWjPGhqPEzLQF
         AGA7vYJHmOFk/9hlDEFJ0oFhVPID4hvRnqrI3FIoLb2gEf6Vwxrl+AO/EagYpowOkN2Z
         BjykI1SaWmwk34buR19ZXPH1O6/ODMxbu0ucegnCN+8JzMEY0gaURiH7O8WfYCWrEyPK
         lIWHXpCr6j3a5r/ERgnhnu2QUbprAoEFSoyAaWfD3eM7JJ8GqtgMzaPuls5XehTiKhPW
         r3wORsvG/KgUa7ZKfmxzxDQGTQBuuZl3cBCDKzkO5pd/wBvFBIcyduyLAWqraTUl2xBa
         jf5w==
X-Forwarded-Encrypted: i=1; AJvYcCU3fzfipyrWrLeYRZBtA7qNVu1eIULM6IcbOxEUNA3+rTs+9nDt+NH7xLD3etqxSKfQykS7XEQTLan8Cl794A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz5Un6ky3boFCgUx0OeEmYbUA7pH8Eq/wvjILKFz4uoDSDXDFI4
	GsNBb2P3iAOGtHz4sIM/dgOleuPzERGnf7kXUt98GnQdpY1JuzC/VGpSPrPZpV4HDUIBkExM5HB
	4Nh2n8z0eF4OiQxLOwn5pGsFK1yMRzng=
X-Gm-Gg: ASbGncvZpUSk78RQ0jDsoe5fEHMjEIrd27F3NS4uid7oYAHjVkpBItIBF9nhPx6d6Ne
	N0XuFVD25RFTh80RJjid+PnPr+rGZS0ZlqeTkN8WnJxWkQJqxJlPzMauwJH0HWmOc0hz2WkSIk8
	cY9h05paepzLHsKFoiTm9lCmAchbWThcRD47yMjhP1UBA3PPuYvLj7dga7Uy/MoqAiEmScrmA6i
	GkFyu9krUk45uJTo4bvVaSO7TaH2k61q0Nlzgw2abxZ+2hT+8uAbIXpr2OZOj5VyWb2UvcrloT6
	bs/VjtiTqwlaIWzGZ1UTpiBPAC98
X-Google-Smtp-Source: AGHT+IF8HoLxCsbxFn0Q05QHNEFaH5LN/KgcQUuwi/NFCX+hm+nzFT1ZjELINl1AgyfVOFTyiPf1ZTpt2LmAPKbOJ38=
X-Received: by 2002:a5d:5f55:0:b0:427:5ed:296d with SMTP id
 ffacd0b85a97d-42990712615mr3163617f8f.28.1761350249591; Fri, 24 Oct 2025
 16:57:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251023-sheaves-for-all-v1-0-6ffa2c9941c0@suse.cz>
In-Reply-To: <20251023-sheaves-for-all-v1-0-6ffa2c9941c0@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 24 Oct 2025 16:57:18 -0700
X-Gm-Features: AWmQ_bltQWl9Zt65mlT3O0wfqqWroGd-22lI3adDJdCXk0hQ4ymeHmC7hV8Eb1Q
Message-ID: <CAADnVQKYDgwgAQ+geFrY=xDxNoe2YuEYVQU+d3V3nMhkMBg1zw@mail.gmail.com>
Subject: Re: [PATCH RFC 00/19] slab: replace cpu (partial) slabs with sheaves
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Alexei Starovoitov <ast@kernel.org>, linux-mm <linux-mm@kvack.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-rt-devel@lists.linux.dev, 
	bpf <bpf@vger.kernel.org>, kasan-dev <kasan-dev@googlegroups.com>, 
	Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 6:53=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> Percpu sheaves caching was introduced as opt-in but the goal was to
> eventually move all caches to them. This is the next step, enabling
> sheaves for all caches (except the two bootstrap ones) and then removing
> the per cpu (partial) slabs and lots of associated code.
>
> Besides (hopefully) improved performance, this removes the rather
> complicated code related to the lockless fastpaths (using
> this_cpu_try_cmpxchg128/64) and its complications with PREEMPT_RT or
> kmalloc_nolock().
>
> The lockless slab freelist+counters update operation using
> try_cmpxchg128/64 remains and is crucial for freeing remote NUMA objects
> without repeating the "alien" array flushing of SLUB, and to allow
> flushing objects from sheaves to slabs mostly without the node
> list_lock.
>
> This is the first RFC to get feedback. Biggest TODOs are:
>
> - cleanup of stat counters to fit the new scheme
> - integration of rcu sheaves handling with kfree_rcu batching

The whole thing looks good, and imo these two are lower priority.

> - performance evaluation

The performance results will be the key.
What kind of benchmarks do you have in mind?
