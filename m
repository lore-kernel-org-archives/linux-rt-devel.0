Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8912B2505A2
	for <linux-rt-devel@lists.linux.dev>; Tue, 11 Feb 2025 15:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739288054; cv=none; b=rekajUPHYCLiM1mvPej76E9Wb6RwThSaedPgO/qTah/lp30vA8ToyYu+DVrDRgl1ztQHFhI/feVXBQ74LSQ4KTE93lmCeb2I++b7wHNSXYV2htsUzrFo6dMddvstoPY4UX3MrXELhLdp99r2EI8Jlwt8keQ6IgP1rNSPayS0itM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739288054; c=relaxed/simple;
	bh=c4U0BQoGEDqvwQiEJG/iNEafKJ/9ljNNGuWV+PcZbfM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C9Hx9S8fq45FU1XLWEkAJK+G3JCYzid/NFdDuIwrpjMt2N4x/N3QbMFdZx/KSaHmNKzubBU/eLWxdFYpql5npAGhrbeX5K99AbUGjE6faglUp+gTNIYUUwEL2bJNGB+G/R6m8uCk9c71sqlvA9fuAx3hc1C7694THabF/nVXH4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kVg7/1C5; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kVg7/1C5"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5de636e6937so10051a12.0
        for <linux-rt-devel@lists.linux.dev>; Tue, 11 Feb 2025 07:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739288050; x=1739892850; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZbL9eQa2NHquqUeuZMpqgcfigc8NbXhYu6ZhdCUgNRA=;
        b=kVg7/1C5wVCKPL0c+lU+2FABhJktznvqJHacq/7ZNDGjz7qLKBdSlG4ZSqDn8L2nUb
         tKqxAkNnSZitrkEdmqmme2o6/kasEp5bFcRbO8hCPpYzDd5lrF1owLHATgKPwFuDw8sg
         bzw0bz5hdaLGZwdaupy0Ol3v+8SqZzTfCTnuXYIWxlX3fEURSeyRH0DinvEVdbE3Uwu9
         7RwUcwzxiqDaQgKBduraILM0Lz4iwCabz3Unn9s1+4A7FPeLUVsftMCkGw1VO39oQ5Hd
         JjPIzd0eMziaIEQ/95m9RHPyRyC9iR9ArQ2HEkTGEzTmzblEhHba+6in3DhyrcUAkJWh
         Rrmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739288050; x=1739892850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZbL9eQa2NHquqUeuZMpqgcfigc8NbXhYu6ZhdCUgNRA=;
        b=a0MW3fF2/n01Bb2noPvYOOi/C+bnOwNfRbBU4kd5HS6O4eoT8MdVS0mr4PFBsESWTm
         4xKsRJ/NAxGFXYY+hPzmivGNrjuqDl9e2jKkikFleqqnzsQJp/35HgozVtsz31tbw9C8
         qFldpBbYJI2dqu/5+wdnTgVNtHQNuaKNO9Kowsry4jvhZJy0kQviALUzUR1nbZoDPQjG
         TCcnn60Zs4Ws8rbtl9Od34gHKYI22L9eQpl7ryjRXcRpf8MXnUtUxwFM0RfyXKqI0sz3
         LQO25cxHq4acJMjw3fjTHnUKflOjaq+yuOLOcjGHi05yGpdiHJ1lSqb0MMAolqvEtfF0
         J3aQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTRIaZQdYZiliByKcBJghnvgA/5N13oMA+MT0ZJSURfx2CSEfjq/yssqT5RNfnucRia0giOle0JjoouQipGQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywu7cdnz09ZqJpJyDH2eAFbqoVcfVMiD4YWxusIERgE/upKL0E+
	BC/7+LIcGsvzd3knOteBAfPWHMblHebuI1/icBcLUnOIzG8VYfmjovp7hiDvPyyKqh3I7ASnosP
	fNBwEkIKZQI9bHyyPJl0grk6AUJDZfTMfQJzEXRYNf/bIffoNGg==
X-Gm-Gg: ASbGnct1WMLjlg1US7FXbscaycn24b9MZ6AgnYIRuLZJPBfBrY7ZPmNFoOd6oClWx3P
	4S7p6rfqTMKg2e8YfUYfMahwYl98rbT7boT3Mj5O8pfafMqxxvMzoJjcBuNXVVYs4GuyW/l7qIr
	ifgcZbsLgbY0lYlg6TLhLciliMloWKpDY=
X-Google-Smtp-Source: AGHT+IHqGDGz0wfrcp45JtErtpRAYfNh1EE57PPR06fLJQNwhTHl/SAaKNWTZ8LVn4rijthtDnq+ZrEwVKQjctxaREg=
X-Received: by 2002:a50:aa93:0:b0:5dc:d08e:e128 with SMTP id
 4fb4d7f45d1cf-5dea05e7838mr88792a12.5.1739288049612; Tue, 11 Feb 2025
 07:34:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250211090511.xeFJVnH_@linutronix.de>
In-Reply-To: <20250211090511.xeFJVnH_@linutronix.de>
From: Guenter Roeck <groeck@google.com>
Date: Tue, 11 Feb 2025 07:33:57 -0800
X-Gm-Features: AWEUYZlq96aEBCvQeCZ-nHsg7o-TOaHeFPxTcHp9j8eLA7B3lgOzEs9a9524BPo
Message-ID: <CABXOdTeLUi8mKkV38SegM_n8=Uyykd-X+n7RysjpgAZfxxb5BQ@mail.gmail.com>
Subject: Re: PREEMPT_RT testing on kernelci
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: kernelci@lists.linux.dev, linux-rt-devel@lists.linux.dev, 
	stable-rt@vger.kernel.org, Daniel Wagner <wagi@monom.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 1:05=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> Hi,
>
> I remember Daniel Wagner has been asking to include PREEMPT_RT within
> kernelci. I don't really know what the status here is. Thank you for the
> work.
>
> Since PREEMPT_RT is now available upstream, would it work to compile and
> enable some of its tests for the supported architectures on Linus' tree
> and maybe the -next tree? I don't think that happens at the moment, I
> saw only a few stable-rt trees.
>
> If so, should I just open an issue at
>         https://github.com/kernelci/kernelci-core/issues/new
>
> Is there be anything in particular you need help with?
>

Unrelated to KernelCI - how stable is PREEMPT_RT in practice ? Reason
for asking is that I enabled it for x86_64 together with lock
debugging and got an almost immediate "sleeping function called"
backtrace.

Thanks,
Guenter
