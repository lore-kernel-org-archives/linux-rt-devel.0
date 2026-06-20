Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B841343889
	for <linux-rt-devel@lists.linux.dev>; Sat, 20 Jun 2026 23:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781998000; cv=pass; b=nX9Tj4B1wqzLgnrV2qcu6/ZOEJvZPMyv8CZvXb7eDMx5OeGuO/M+PqLk/TBqcDG1JuipPvP9Xl7etXo32YMWUPb8qCa0FjljPakqtQ9NhIsDSu+3s5M1YMV7bfqNdt/SGp4AEfBD24uXGMcV4bhrzhqIedKDfO6b1WgDvO14lPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781998000; c=relaxed/simple;
	bh=p7A47r01QLLxvPJa8GPartZIvuyI0yW3DvDkorSmJIg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HOTMr0YWChrRzXiXv5loA7R7Qmacs9doVPzw2GfQTkNjLIz4hN787xCY0wNAVC1Tf8og4Y5F89Tox9/euTuaZHMop38jUw454JdQzJ0Vvz4AWjQk8IzztjpW6uJRzff3Vkgx0MHWnig0xo4wcf8gVgWd3ayd8ayvKsZOuRvQYbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oGcWa//b; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oGcWa//b"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-6607e80a846so3382112d50.2
        for <linux-rt-devel@lists.linux.dev>; Sat, 20 Jun 2026 16:26:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781997998; cv=none;
        d=google.com; s=arc-20240605;
        b=jrdGwY3t3o/dzb/SL/nkLxJJr9SnJPF74qxfZxheIqgk7pYiK9vx7WyaRAWc6+m06l
         N5R5skUnlG9eFmqTsyT4MeSZedZbD4PIvOreR41dfVoPER/6b3xt2HPv5wqA9fkC2Zzb
         u5r2V70aAWbo+Q08nOpSZ54PvZR2efWy660On1MYiHKrQLfz9ANZhww1zqhsOt9KP/Qu
         kna4/P4nRv2UfQ9s6o9Nbjgg4eTMjHUb5tEJDEpiB4deA+hfu57ot8fPUoyifi9JXbbE
         uXsnygQ20ChQIOqe59Mz98M1f7qMaF1b2VLsHSTZeTTVTGfMRSu1Uinlg8Cm+Ms62mtl
         +YJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=y/VTsGzs0OyEB3v9Q0VmgQrEz1yxfxa7BO8lFW7ZSrU=;
        fh=VpyLAG5Hfm2pkgSWqAyJnJMoTpwekuw5Bgr7W4ZR8YE=;
        b=FnuXE/9n/uUIk/x9oNcz+aPf+t2UqLeZ2nsjDTrnjiQfwg7Wpf5ij8XF7cjT3j87J0
         iXvbuKktDtrqczX83LlaQlXeje+TmuA0VuLEZnA6vEhEW1uuL9/anZ3GL6P1FNEimldJ
         A87uAXDEctAtWO4kbWDnSBxD+gVCkbcJU5EVmC10BEoArnn+ufRSWdVxRnF0Y5JfX3Yv
         1Smz8+NNz9sQpxEA1Y7j9bv1hdPrIztQ9LYAKsgEs5cfJzr3Tmvhbq+z4ZcIpXyCiDMS
         QIrn+zQBUCrraJBWDc5yxcZVl0e7P+wMzirOlX5ZBP1a+qWQNTjieFbI6/6huL1Rz+hZ
         FBlQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781997998; x=1782602798; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y/VTsGzs0OyEB3v9Q0VmgQrEz1yxfxa7BO8lFW7ZSrU=;
        b=oGcWa//bGe9FW8+7z2/BxlAIgTBkhMA2IAeJPsZ0++vvj4p0TtFhkGbJ4fUywEbm5S
         S1+moCyzs4dJ7Kw5i4zmqh7uF7j+LiJxW38KE9WblWZD/iYo0lyKucOhuJ7sEWmQMle5
         0SKyCBNuLj8JMD5oBbBY1oaHSsEnHggEvxLjvKsK2k0pKtIN6kDeZn0zvh959jusGGF8
         yOXI/H9ZOtS1lPThJjDTJOO3Cc69Ou0L4nBoBwJbS+Bvq+grg7rw7uEZpVEZO6NfTF0y
         mcA5uTkJfqMy1rpdQsJtdY7p6g+dr9aFUUg5TUHdWCvHyunei7oRLvpE8HQ0sVwzhqmk
         GT0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781997998; x=1782602798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y/VTsGzs0OyEB3v9Q0VmgQrEz1yxfxa7BO8lFW7ZSrU=;
        b=FtX+iEQUPY2RCaGB6QxTyzyJtTY0B9LX9SX6RiDYtOSjuqBcO/HaKXmq+tgjICXFQP
         z/u7K2GRLYHx0HvtOzt9/ax/XNo/fBHgmFZMLrqH7A6J5IWtGCeDS9UAk8N3LkuHaoV6
         8iEbvQPuZ5Stno3uSw1Kouctung79N/c8IHQMxvY7wxKf+VBw3VSYeuOyvhF9xSxLilI
         jpkYjeWJNQ478faOfiqcaI2I4paetFJxqI/U3FTP3UO7x2LCNtWFLT/Ar84EVF95j27V
         z9zVzOY44cfQ5rVK1eUwHqjm3KsrhgvvQAEO656/roZ3IPdY2Q/axxD0egUiUM7bdCGn
         mgxw==
X-Forwarded-Encrypted: i=1; AHgh+RoFHR51EawEs0euQIyal2jetJvQlO9pAcWC36mLlgbOJA6AyOvk+GXMFEedHSGxsyZRKldwSQfjAV+XzpOo8Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzEeNp4C5qz0i9dKaGMVlgNOO5Tnkn02IVZPo9ZtQtltZKsYET6
	v0tKcOQEmvWWY3XNOgvRyqJ60ZhLQDHiaXPVqgdeR1U/ziKvSX05xtKozQzrgCTtP1rveCd7fRM
	SH/SMONlpNiBdaXlZeaq0Lt35KhbqYtc=
X-Gm-Gg: AfdE7ckyShwwK60+dxPyljY125Kvm2RbhXBxYDH6H0r3RYMdFVqKXDj70t35UBk8rk1
	0t9VRh9SCX4C83DuD3rVqVYP7mflWnJ0JU5c4lHLNjozS3Fb7Ys06gRgSKuS8h7WX6TNmyDzn94
	reMC0fLoEf/VFPFd0IioVb5pFDcTMBFR9t6IYI4S6NYuB3kMMuau8yGBuU/nYsyf5BsKrCejuAk
	joPHNbQRb1nl5yX/gUqIjwdOm0xVoDS2sVqdu9Lpj+RHLfa3Ck/abhPnfmsVyEecEA9Lg5hllsn
	T4zWSMkwVMOHSkY4EOVhJaa0PktD2SaKkqgWQFGdnyorxsl9xMCWGz4gGlEqKyTDgUYEsp2o
X-Received: by 2002:a05:690e:2251:b0:660:60a9:2b20 with SMTP id
 956f58d0204a3-662fc678571mr7897226d50.16.1781997998246; Sat, 20 Jun 2026
 16:26:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260620080802.35165-1-kartikey406@gmail.com> <ajbVDMX0mSnLKe2X@casper.infradead.org>
In-Reply-To: <ajbVDMX0mSnLKe2X@casper.infradead.org>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Sun, 21 Jun 2026 04:56:26 +0530
X-Gm-Features: AVVi8Cdt0nLqXewdAJjUwqYgz5xg7xyNbEB-FkrRzdLGTwWLchWlfatOaCcEbA8
Message-ID: <CADhLXY51V2kQqKefy-VgUayYBCHcyk8vPTCq8DWCDgVS_cG3oA@mail.gmail.com>
Subject: Re: [PATCH] ocfs2: fix deadlock in dio write orphan cleanup path
To: Matthew Wilcox <willy@infradead.org>
Cc: mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com, 
	bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org, 
	ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, 
	syzbot+ce129763ce7d7e914739@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 20, 2026 at 11:29=E2=80=AFPM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> This seems like a false positive.  You can't call write_iter() on
> a directory, and orphan_dir is always a directory.
>
> I would suggest that the easiest way to make this warning go away is to
> replace inode_lock(orphan_dir) with inode_lock_nested(orphan_dir,
> I_MUTEX_NONDIR2).  It's a bit quirky because, well, orphan2 is a
> directory.  We could add a seventh lock class to
> inode_i_mutex_lock_class, but that feels a bit excessive.
>

Thanks for the review. I have sent the patch v2 with
 inode_lock_nested(orphan_dir_inode, I_MUTEX_NONDIR2)
