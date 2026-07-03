Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C0237F8BA
	for <linux-rt-devel@lists.linux.dev>; Fri,  3 Jul 2026 06:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783059957; cv=pass; b=Udpms2s3cARrx1vmqq6CcbmdWgeSiydpteezORo4uX3y+X5PrA0yMV68x+w/SiE7vzZz5Gea/RPpp2SxVU1EP/49xhAhfGdT6iwEp3mr/JA/vo99V+gLhjD9rfLznET5iOf0juSbZeVC4eD14JyH9HXIeNVRyQgyUL4cS0acqtk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783059957; c=relaxed/simple;
	bh=gu23m3G9I8LRrXwsMirKiBM83umbvVFeycfI4F8fQoU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cKji4R3Lzz4psJL0wGlQdfWNHB2row1K5Z2HCtTWfTY3KoLctvMU4YXhR6Vza4wlj/2FB93XpWmQuEv/dbX4X8iLAt5nEhHTM8XegElxXTHVs5vVj8KxCIkK8PoSgq+9HBwlpnxU0MZlzFznRobj83/bho3gcwrWKKm8G5ke9Sw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VZRhzvax; arc=pass smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VZRhzvax"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c998fd549a8so150528a12.2
        for <linux-rt-devel@lists.linux.dev>; Thu, 02 Jul 2026 23:25:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783059954; cv=none;
        d=google.com; s=arc-20260327;
        b=hFck3WLGO+5wNqOyaAzbbR8Kf5DDZqgPLOc1ApZMq2+Dnw7QXNDigNUOQSMJV41aKd
         mq6rHxfWlWAqH/5lh6h68976LV0MZuy0SS06JP0LRLb5qREYxFcAVrn8a3xhSvayxUYs
         o9CPvIJeZtsPgzatxu1Sl6Z7M2aJhD+7Nt1v6MadQVhpMe21jgnm0F50bjVBGLEWJxP+
         45SDNy+Qhp9PDyJ+08X5VnZZ/I95klPqjIUxESrRNVVu7i0IUbR5wKGIR/U47pJr3xF1
         uWbIkco2d0ap+JV48+u1DQde5kmeZEWQWYxab3aFlBMJJVISx2uS0EhhM1qrjMqxC60U
         bPTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BSF6P/7OY1gFGFz/Cqzg8XWTkIoYPCEYs2S/9aAkdwU=;
        fh=qHihw738BgbvipbzfgWeLfBCOR+W+w3ctTV6yFEOwgw=;
        b=c2WhUabdC1J60SnjmhfgEBKZzJcktJK7W1eCf5qKu01ctbgNDHavwwp/eqMsom2Al2
         dtQMHPIvYW2w6rXTY8slRwA30lzvYzlTp4jmgNjb5mDXrbz94ou/f6MfqpJ7svLv+jwu
         Vdj8rdYpmYi3Nvc9/sHHBg6xIzWcasoRdYNq991xlWSP6snCtvaJQh+ETiXKde6mlRFG
         iQeQF0lkD8Lc0PrPPH2YuQ4x3SVeVU5BktWeEkaVOfZGe5dyW8KyoJSljRo4rw60OL3d
         YXw+/dDvUMLIHsReELZTcazMw5FmPp6z7B0iv5t9VumyzHwi/RhJA0opoEzYeXuUUngM
         BD6w==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783059954; x=1783664754; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BSF6P/7OY1gFGFz/Cqzg8XWTkIoYPCEYs2S/9aAkdwU=;
        b=VZRhzvaxfLmjf/Ql7kRCrNUx41v1pgPI+NYlm90VWxTNIMy2OSSSMv85rBnLjm6NyI
         c7dk09P9UnC4mnpVzqDhOMA38NBWIvcEXjQz92s63YT1WmyYSoWO8Rdbm6pdOLs2s58O
         mglZ97+9xV9Xe87yGvHy3j5HKkOQ9+/ZfKmHuEWnMOKMvrzSTfQudkmDPzl8gmtqYsjg
         +dI0n+NEu3QPfdpJz14CprAZxf4vXq7GnS0IlynLHpaPblrPCmDR9rChgFwmJxv81Lnk
         xVM3WLsDWu53X55sIjyDdeUtHzFm5hrgE/1uhmSb9AEeyTDCfvN8RUTNjsxi6vuDNDj8
         Hkyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783059954; x=1783664754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BSF6P/7OY1gFGFz/Cqzg8XWTkIoYPCEYs2S/9aAkdwU=;
        b=VFHB/q+8tv+yhF9y0/JryEmJ+ICi4nwEgnSxebmWg09xhUGYPEdta+JTxPb+LTXl44
         KtJ/nnqDUbYlJtsxXfG5ikamtpxJ1GY0rCGZimMvpALctSOrnQzooTkhW+tq8U6U18Fc
         fCx+OGaayzn3cYgFU/HjYZeQCvYe/f6A9HUxUJU9OUDXllzKyQCAcx8P1Yv4CF29qe4y
         FW3XKPMZxFWSo3EMj2VGnpi6Be1w6MtG4qIIUo9yoPdsTREN8M90SGHNmHWlbZM7IVna
         +PHoO0YHb8BuF3hZGybodHuvKVzTLsfQ6jhJeJ5wrvsm4hGlNqxh9sJIar8fehecrd/W
         vVVA==
X-Forwarded-Encrypted: i=1; AFNElJ9nDThKuU7DRd2/IVlbS+FwAhF8SheSCOO+XCLb5pOVttvAta5jWlftA4yj5A2vEmYWs/nM6JHfEE7IFNBPRg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy8g/x0Yw/zJebJBCKd3Sw1rbubfn/HSrOuhl+7wr09JMJL1yG/
	EoFk96IPWWhTxEIn3Jtsddoy8J4gO8oOp0aOwP44oIefbHjaMVlZQY+Ifr6c0Cy5dTlo1fYot2/
	5qkS/Q3zoVWZUCtYj6nhXqoejJfLnHJeqJlFqgTDV
X-Gm-Gg: AfdE7ckz5OAkQJqHQptJ4wvweR4KtOlnm6r0ytLRilVXbMeY4Ga1edafczInav/8c2X
	RGvG0+zdZRpLzcT95fQyEPIimvZEhomYCP+HXJTxyqms8vo6JZM9n5naRJB+pYryhiOB7TDfzM7
	fF+AEsliSLMe9tF2vf9W7sDtMZXk6bTYuz2OQAtvvcqKWSPUrpWPS/q4I50ybG+ZAffVgONSZOR
	YDfrc3qcUfby4KzMuO0wJ8uUzclI74Lfudij0j8vfDACNTsi6FqiRm6jHqUKINd6k7jky373Cct
	JRn/n1+qW6yLngFmuNAxMfCt2bS7KYyDkzgWwVgeDiRkB2bAJq+NuQY4PsZGqKhMPFKw+Lb7Pcs
	1zIXJxSIngHb4w7s39g1vn4I6A7hYJ4syv1zEZKfq
X-Received: by 2002:a05:6a21:400d:b0:3b7:d8d5:2326 with SMTP id
 adf61e73a8af0-3bfed0e290fmr10485150637.1.1783059953937; Thu, 02 Jul 2026
 23:25:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1782922354.git.namcao@linutronix.de> <e663a83195f3d9f6d7ad4907c37ae3e45c151062.1782922354.git.namcao@linutronix.de>
 <20260702163608.0207A1F00A3A@smtp.kernel.org> <87mrw8sjo3.fsf@yellow.woof>
In-Reply-To: <87mrw8sjo3.fsf@yellow.woof>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 2 Jul 2026 23:25:42 -0700
X-Gm-Features: AVVi8CffnuaY4KiLN4AyhU_3QHylM_R_UciFhQADgsvWNfXQqFEwJUoE2kfoIl0
Message-ID: <CAAVpQUB+LDxRrF66=NKwLAdLN8kt+Hssm_KBc2oc_q6FTJF0VA@mail.gmail.com>
Subject: Re: [PATCH 1/2] af_unix: Do not wait for garbage collector in sendmsg()
To: Nam Cao <namcao@linutronix.de>
Cc: sashiko-reviews@lists.linux.dev, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 2, 2026 at 10:53=E2=80=AFPM Nam Cao <namcao@linutronix.de> wrot=
e:
>
> sashiko-bot@kernel.org writes:
> > Thank you for your contribution! Sashiko AI review found 1 potential is=
sue(s) to consider:
> > - [High] Garbage collector is no longer scheduled when creating new inf=
light FDs, leading to permanent cycle accumulation and -ETOOMANYREFS failur=
es in isolated environments.
> > --
> >
> > commit 506189bd29f8ad56f5d9e51f3e0216203ebad5ec
> > Author: Nam Cao <namcao@linutronix.de>
> >
> > af_unix: Do not wait for garbage collector in sendmsg()
> >
> > This patch removes the garbage collector scheduling and waiting from th=
e
> > sendmsg() path for AF_UNIX sockets. It aims to prevent priority inversi=
on
> > by relying on RLIMIT_NOFILE limits and asynchronous garbage collection.
> >
> >> diff --git a/net/unix/garbage.c b/net/unix/garbage.c
> >> index 0783555e25266..f180c59b3da9d 100644
> >> --- a/net/unix/garbage.c
> >> +++ b/net/unix/garbage.c
> >> @@ -300,8 +300,6 @@ int unix_prepare_fpl(struct scm_fp_list *fpl)
> >>      if (!fpl->edges)
> >>              goto err;
> >>
> >> -    unix_schedule_gc(fpl->user);
> >> -
> >
> > [Severity: High]
> > Does this removal prevent the garbage collector from running when a pro=
cess
> > creates isolated socket cycles?
> >
> > If a process continuously creates socket cycles (e.g., passing FDs to e=
ach
> > other) and closes its local FDs, the sockets reference each other in th=
eir
> > receive queues, so their file reference counts will not reach zero.
> >
> > Because the refcounts do not drop to zero, unix_release_sock() is never
> > triggered. By removing unix_schedule_gc() from unix_prepare_fpl() here,
> > unix_release_sock() is left as the only trigger for garbage collection.
> >
> > This could allow the inflight count to accumulate indefinitely until it
> > hits RLIMIT_NOFILE, causing subsequent sendmsg() calls to fail with
> > -ETOOMANYREFS and permanently leaking the network namespace unless an
> > unrelated AF_UNIX socket is closed system-wide.
>
> Sashiko found a valid issue here.

This is same with my point, and

> But this is a pre-existing issue. It
> is not introduced in this patch.

your patch makes it much easier to abuse.
UNIX_INFLIGHT_SANE_USER is usually much smaller than
RLIMIT_NOFILE.

unix_schedule_gc() in sendmsg() is to self-regulate malicious users,
otherwise GC relies on unrelated AF_UNIX socket's close() and could
be triggered too late since GC is system-wide.

Previously every sendmsg() had to wait for GC, and now it's only when
there is a circular reference AND user has too many inflight sockets.

Please fix the root cause; the former condition on your system.
--
pw-bot: cr
