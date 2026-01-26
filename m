Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E68253958
	for <linux-rt-devel@lists.linux.dev>; Mon, 26 Jan 2026 06:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769407805; cv=pass; b=fRTAIomNRAmuYciW0ZIxfZpLSJnq46U9ICKMDKuSpZPl4RRMFSCUJaikvafSh/fUyAXIMglvQpmPASsfW5lQ2t70KplodC4N7OPyb2gM6+jM1SfN8sb+KCvODnp/qAG+FyFRqoa9ynewdAa6JrevEZG4J2Gyd8r73UuKMEcl1XQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769407805; c=relaxed/simple;
	bh=2H30noRGjs6dlYj5U6mmK/jvHGeZbAyKXQsiVYLmKCc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F6REPg68R5SEZ9J2qKLj7osqy7BhLFYHbanlsCttQuYVX/W56DB/CKc7yYVpWtPtEBkGrrVOfEy1gVqt4AzTo+p8qFvO/bVk/OLjjtCMpNR/TO1Dq6qTHcqli/qjCLbLrEN/Yu/H2IUuN/j6tayEY+GITzj63xYvZWznKG1JyOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yIKPxP6T; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yIKPxP6T"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-50299648ae9so711811cf.1
        for <linux-rt-devel@lists.linux.dev>; Sun, 25 Jan 2026 22:10:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769407802; cv=none;
        d=google.com; s=arc-20240605;
        b=Dvt1bftOPvDn2V+6DTsSn/0Z9WvcESLFU7qqfkIO+3wULTanqvmh3rpDKpvHOxF6kb
         d1jFgRetTcdej+GylFrGNT3Veeozw9MfFQUlPUQIi9MZPfgoRTZnKBUT458tTFIcUlRb
         nqAzy3uOosTcDnUba/pUlUpDNXyZFxXHVo0UZORWsyupAlkMU7r/FoPUKpyw+5zj6/Ol
         bNQ3t8EVOIe/8nyiUk3wMDsJzSgXETO8w2sq6YE/SF7EnCUAKv2uFPClVdQy5fBHyb1A
         +Lfh1cvVBOE5fEMEaDCodsfbSSAQPm9KodXU8v1bWxsr5H9hUubZGlYyhuLHvf06pm6R
         xNIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2H30noRGjs6dlYj5U6mmK/jvHGeZbAyKXQsiVYLmKCc=;
        fh=zSUyEYyjVcHokXGQpMlcJI6R0XWCRVd9PND6Hx4hxu8=;
        b=KwPNj4EVw4VhIMTBbxhLsSYMO+T9wk0D1FUaPtdnMJtAawNlxQRia3sRGu4EJeAi8K
         BXJ8JC1mTeE1RdJsG6Wg/mrl8XjPlrSdiJJjTdsXwk2g9XjSm9bLVNVp2n99oi+MZvNI
         WOY+7ip6FzPdZ0rFJ99bmyu8S6KSnfMmLBjXe3BLKdGxv0xrw5YDNal9yXXML12d4Ixd
         4jbMed5DHDZHsA8XyYkjkq66GePShy9MaCnvqrzBAdvrx7M3HzJtjAmHO/PSvP+sQukM
         yScv+EDACjSHsJQ83DJOso6CWcU+2bMdNvHKXA2ilSIZTvXxHRe2TeTkvvTvYZejPgO+
         E2dw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769407802; x=1770012602; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2H30noRGjs6dlYj5U6mmK/jvHGeZbAyKXQsiVYLmKCc=;
        b=yIKPxP6TUu5weabg18jOeX7VFNgRaMa/H7jJzsyhmV3tdyBgPL7PeFnwFOH2SM+BgB
         7hXOjuGi28Wv9dgthfSDM0W7fHHABVKEEhMgfuFp9vFKoDbGLwrfS6QxnJ+Jj53pHqdZ
         WUD1kd9X9VwatcSSnS8gVjB/PhPHVA77xX6kZC4TLafjdZhY1+f9LQuLt/cSM1h5rMP4
         KCUG7J331q9HtPBg/OS1sBACb/h8RLEdRg6s9AW+FMleHytNxpJWNABxroXGrfSItQpk
         Jc6uuUurnDLwcXN0WAyeQd8wSKw+G5jNljwLYSq0vrSpb6+BdHmZZ0OR0LOgcSX1uxOH
         ajBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769407802; x=1770012602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2H30noRGjs6dlYj5U6mmK/jvHGeZbAyKXQsiVYLmKCc=;
        b=JRyUu3t5iICxsfi83INmrwPfVauo/Z9GbUBmxLmLVdYxHUJQoZLz7Ww2STwgQBVr6O
         GXfw6Ft31RQ6uRxrlDIO2qn8qNtJTMkhd9EIb3WxLtvpEhW8uoNRuAtp2GdGF5J0quDX
         9h1s79LbCV6Eca6NoTGHRm0etjr/005cWzrHCvuIJ+Q9neN7t2S4nESRnDo/GDvUQyy5
         4qmY/HvYSBZHNdWzMVwAY1g+u7Wk+XqcrfeE1O9yOaWUpH9GTeiNEBvflRAg4u3J8byD
         76hsNVczojxjdJFs458phtZfPA/vZHByO7vJJENoxTShzjoXWN3R4P4NZhhF+PJ1zZ8T
         HCwA==
X-Forwarded-Encrypted: i=1; AJvYcCXesYafT4CDU9vOmfEVY8knwW9DEKt2lvmShLF2OnGOnUIwSDqgcStR0S1BaG5o/hxHAJD2lBBTs2HoKfeU8g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx3F5UMXUEb9fkBWYlzwKfwxBmp2Mu8qycclIdn8W0HfkbjJvpt
	l0GOX92e4pRVfJA1CN7kZ7y7ycpwZpb3Exzg0r7XV6LspawnB3UQC6+9aXiT6DBOHa2c612OIsS
	RMQ3jD0qgUjmcBr54xOLk46FOfWpgVl6A7qGIK7xU
X-Gm-Gg: AZuq6aJCwA1KjXYNG7Uq5uhEG9aBJg1ZH9zZFmoEIbIKN27c5JcUcs2KEvwyYuSbyZC
	guGSJJu0VIt5/SVbDnNYuHvXrOdFe1PMVmTekPRy/mlcXfOEhLxjC4I29FuyBLZLPHsoZ41uG4T
	vCuxvamdugFp3gYxVb6vt8Dm89T5X2AzykKMHA/JY/AEDtDumHWqXWT+mskLiW1NnBq1vu6y6Ql
	xHcpOL+6gRJR5GxM2f8SUhm1J6vHaYdMQstvXfkjw+g1wagHZVCEl8qE1GVdzQI5lLr6Q==
X-Received: by 2002:ac8:58d2:0:b0:501:5180:3c90 with SMTP id
 d75a77b69052e-50314378ea1mr7863181cf.15.1769407801346; Sun, 25 Jan 2026
 22:10:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1769086312.git.lorenzo.stoakes@oracle.com>
 <4f95671feac6b6d4cea3c53426c875f3fd8a8855.1769086312.git.lorenzo.stoakes@oracle.com>
 <CAJuCfpEULwMTxAzxUdzfpHe2=+umXL6HFMvydkqW=tP8mB2ewg@mail.gmail.com>
 <c7c8158d-e360-4a29-9e48-f2b45b9ca147@lucifer.local> <CAJuCfpFbsAHr76ZfUEaRLzdxQMDjPEP+bsLNC35X9t53G_uqAg@mail.gmail.com>
 <c4d64bde-831d-4f3e-9b92-68c1beb70599@lucifer.local> <CAJuCfpE3D8XyR5wy+Zzq7TX5am=q3SrevarJaf6Z7-k-9CkmkA@mail.gmail.com>
 <023e56e5-1c2e-4482-91f6-32765cca4bda@lucifer.local>
In-Reply-To: <023e56e5-1c2e-4482-91f6-32765cca4bda@lucifer.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 25 Jan 2026 22:09:50 -0800
X-Gm-Features: AZwV_QgcAEK7MQNe5kQXzo6PF6GXSdKbtlaBVT_oqajfvBnts94OqV1Gzyhylp0
Message-ID: <CAJuCfpEbmc_hhom3A6_V2wJB1rxNHMfW1ebg2TnnMRfE8asahg@mail.gmail.com>
Subject: Re: [PATCH RESEND v3 07/10] mm/vma: introduce helper struct + thread
 through exclusive lock fns
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Jann Horn <jannh@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Waiman Long <longman@redhat.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 24, 2026 at 12:54=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Fri, Jan 23, 2026 at 02:07:43PM -0800, Suren Baghdasaryan wrote:
> >
> > Sorry, I didn't realize I was causing that much trouble and I
> > understand your frustration.
> > From your reply, it sounds like you made enough changes to the patch
> > that my concern might already be obsolete. I'll review the new
> > submission on Sunday and will provide my feedback.
> > Thanks,
> > Suren.
>
> Apologies for being grumpy, long day :)

No worries. I get it.

> to be clear I value your and
> Vlastimil's feedback very much, and thanks to you both for having taken t=
he
> time to review the rework.

The cleanup you did may not be the most exciting work you do but it
really aids understanding the code and its intent. Thanks for doing
that!

>
> Hopefully that's reflected in just how much I've updated the series in
> response to both your absolutely valid pointing out of mistakes as well a=
s
> suggestions for improvements, I think the series is way better with your
> input! (As always with code review - it is just a net positive).

That's my goal.

>
> Please do review the new revision with scrutiny and comment on anything y=
ou
> find that you feel I should update, including this issue, perhaps I simpl=
y
> misunderstood you, but hopefully you can also see my point of view as to
> why I felt it was useful to factor that out.

I started reviewing new patches but need to check the important ones
with fresh eyes. Will finish them tomorrow morning.

>
> In general I'm hoping to move away from cleanups and towards meatier seri=
es
> but as co-maintainer of the VMA locks I felt it really important to make
> the VMA locks logic a lot clearer - to not just complain but do something
> :)
>
> In general the issue has been around abstraction at the 'intermediate'
> level as Vlasta describes it, the public API is fine, so just rearranging
> things such that developers coming to the code can build a good mental
> model of what's going on.
>
> So hopefully this series helps get us a least a decent way along that roa=
d!

It definitely does. Thanks again for doing this!
Cheers,
Suren.

>
> Cheers, Lorenzo
