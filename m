Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2C022FE0A
	for <linux-rt-devel@lists.linux.dev>; Fri, 24 Oct 2025 22:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761345150; cv=none; b=NtfCZZLDWFUtw1AuOfTgnAzEHilNZ/quMmYi7/6iUddVvXPcW8K/3ZeXzRYorhb71SbQ3FjFFywrCxbEMwVuRWNds1hN5diOgeYTyR+gmEEzJtGQVFh1VwGaPo37q2MVnYEEYwlUVLhjy1ZzxEv1xsfXIXbP2pjMhKYNS9TzxwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761345150; c=relaxed/simple;
	bh=HPGTvP3gKXChLNxuAJRLhDCCzuFV1GUXxkrKedc94G0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=POdEzfy+0Ri01R0ulsdIAMcmX1hUi/e8P7Ftx850+Q29vWyZBiuJYTq27yFNpiE1pj6IHkvWVNkNQxpVSIl7zsz3irpULOMxft7ztIzphp1qotm3uDB2Pt4HCZsEluGm5Ymz0RXBnxv2cX+gij+4cIoDg/2te90N7RR3q6hCjTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HyLv4cbU; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HyLv4cbU"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-427091cd4fdso1525691f8f.1
        for <linux-rt-devel@lists.linux.dev>; Fri, 24 Oct 2025 15:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761345146; x=1761949946; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HUfYp53fu94dUtqrZRLYGe5gVG2u++6KcY9W1vIJxhk=;
        b=HyLv4cbU6W/DKy6uEdW0awkC55ETcBk39jWjEBBg5pNzKn4O6NRzrA2NcsAJnj+w2U
         qJR70SVabWARRCKAFAKM0W44pe7V37Ti51c/XOuvWUZlx/S3dfoyI1JRj9rqX+n32Kxe
         vg2IdVuPsbOuxay7DgJXfTI6XlvT67xq4z806vgrxJ67FxYMEA7r1rDG4At6Pk24ncXz
         T8kdlE5iqyh4YwlA3YVeB2hVJXfInbsN3ICwdAYm6RZOvipA0BF0rI+TSgD2WjnSWS18
         JuJoxorztLVfCPR3EpTkUiSagaLMrXRNJBQIlgTILUZEgMXsIO71v/QR1kkn2Wrwj3jQ
         8gRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761345146; x=1761949946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HUfYp53fu94dUtqrZRLYGe5gVG2u++6KcY9W1vIJxhk=;
        b=fFAFmFkuqT1qkqxA5dIbKlT3aeEK1X9cibL7Yf9E92P6sOr3xv4Xw5EhhP6RkDUJcP
         Q96aHyB2XXwScopKkDfGNCOP7vuOJ4M0Zf1VX7n31Jm6YR9OxqYfhILqA2mE0nwJ2AsY
         tmuL4eLwuSckVWV+SSfD3br83HFCjBW9Yyo9SWVuDWsmUXUVXeYyMH2pJOwIsFGPkqbF
         OvRPj0iidUnGKlZDqSSWhZ/gjm6kinXX0k7QDe9ocpIx6XOKY4lQuPFfWclOsbtZiWFE
         N6kAwARc6bRD6R7vL0wLJ1/K8RgTgrXnK1hRPtigZbWRcF4QdrNp6HN3ZJF7JEoAm2oh
         PSIg==
X-Forwarded-Encrypted: i=1; AJvYcCVdVnS7j3q6mEtvLlxAp/NFLrw9WarSl9VRA185xRnkZL0uLNJT6QBucKQ8QqqGqvJ0R4pL75jxUlhTnBWKUg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yygc7eEfcvlEvrMicxDfOncJodb23E6dQgiSEue4xZR0ds4b0fB
	QoIGH4neJCVvcvPzDSwA6G6fncqQ8xxMFQhcw6Wgm+5j0Cw0kgleg0rmlJjkrRxGKhJy32CHbVa
	Ix/qoQpNScXLUC0HYbpWHXzuODSuQTqY=
X-Gm-Gg: ASbGncsTkcLKQ50iFoPj2okYX/4Y4zZV+rhd4euEMtXUSSdLkwPa3lYBRgiTUSCCDeN
	sbU/WtJOjUUcqdO+baK56l3QPXMRQefVoI7ju6SNsGPYe6joJu0bHpuX9koKQtOL25DcjRWj+NL
	IHnsGVxoRzSbeSlxMq/xCMidTF1x2/6WRylbalRbbWQ24EmUQ/SKQ2QvbU81SxucHfH2JhFNud9
	09t7wg6zEjRzn2nAVWX2SMV4FGDxHWDLfuPHXc05KcVqr1PiBLbcxeM8pz29GmVf4Y6w3BEkSK8
	Bq45iQH0cT2SAPAp7g==
X-Google-Smtp-Source: AGHT+IEk6kGBtRPTTE7UK+dCfFed6KOoSdQT4rrIfK18Wcd+iW19phRfPOMaAHllUvSpuZUGkBdwBVCywmTCWEggRpM=
X-Received: by 2002:a05:6000:200c:b0:428:3ef4:9a10 with SMTP id
 ffacd0b85a97d-4283ef49ddamr18538286f8f.54.1761345146453; Fri, 24 Oct 2025
 15:32:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251023-sheaves-for-all-v1-0-6ffa2c9941c0@suse.cz> <20251023-sheaves-for-all-v1-12-6ffa2c9941c0@suse.cz>
In-Reply-To: <20251023-sheaves-for-all-v1-12-6ffa2c9941c0@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 24 Oct 2025 15:32:14 -0700
X-Gm-Features: AWmQ_bmYxy3mKLZGuaPpnI1v7zjS22cZzV3kwSBj_coWNlSrdgc_1YOXiQjgS1Y
Message-ID: <CAADnVQ+nAA5OeCbjskbrtgYbPR4Mp-MtOfeXoQE5LUgcZOawEQ@mail.gmail.com>
Subject: Re: [PATCH RFC 12/19] slab: remove the do_slab_free() fastpath
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Alexei Starovoitov <ast@kernel.org>, linux-mm <linux-mm@kvack.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-rt-devel@lists.linux.dev, 
	bpf <bpf@vger.kernel.org>, kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 6:53=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
> @@ -6444,8 +6316,13 @@ void kfree_nolock(const void *object)
>          * since kasan quarantine takes locks and not supported from NMI.
>          */
>         kasan_slab_free(s, x, false, false, /* skip quarantine */true);
> +       /*
> +        * __slab_free() can locklessly cmpxchg16 into a slab, but then i=
t might
> +        * need to take spin_lock for further processing.
> +        * Avoid the complexity and simply add to a deferred list.
> +        */
>         if (!free_to_pcs(s, x, false))
> -               do_slab_free(s, slab, x, x, 0, _RET_IP_);
> +               defer_free(s, x);

That should be rare, right?
free_to_pcs() should have good chances to succeed,
and pcs->spare should be there for kmalloc sheaves?
So trylock failure due to contention in barn_get_empty_sheaf()
and in barn_replace_full_sheaf() should be rare.

But needs to be benchmarked, of course.
The current fast path cmpxchg16 in !RT is very reliable
in my tests. Hopefully this doesn't regress.
