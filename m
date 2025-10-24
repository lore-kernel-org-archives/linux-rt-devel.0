Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D0B2882AF
	for <linux-rt-devel@lists.linux.dev>; Fri, 24 Oct 2025 22:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761345292; cv=none; b=ucuU9Ptod7pzEYJms8TySqFlAe14gZthf1jmlrjff4HvCgy/QivBrElEd1jLlFz81jpmsznZqxDsVCUfrVHeTyRRtGVEkHEacpT5rP1cbQ/AhiyEfOCi0jmmA4xl4CMZqY7BPrK+7SE9ntLnsk6OqDwE6PWFyjoBgB8P12qb3Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761345292; c=relaxed/simple;
	bh=/1lCqzDVfSqKcHOVvqPIUIhFwtXQWPe83gIVdwmBx9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uDWGkZCloUswJcQjBW/3ICBziZpLfMBGHppATnsBJ5QSyXWpj+x+y1P7HNGgN2x9shhAnElt1dJGqOwRQPxqZcgZbZlbAjh6WS8bQwbuqdBMiaEdegtFisW54GZxSoDM52kZWoNusx2oXSOLOrppncuSngzDX0fDNyGPQ0X9eOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BLs5aFln; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BLs5aFln"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3ee64bc6b85so2581218f8f.3
        for <linux-rt-devel@lists.linux.dev>; Fri, 24 Oct 2025 15:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761345289; x=1761950089; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dgWMmy8jJ+GexnEc4sqtdfOGQCxpNGU9Ux5BrjtS6oA=;
        b=BLs5aFlnGft8xWzP9ja3MLd0ZCplaxW9TtjOQ/+ArOhsRNtgacZ8cQUE/9USPn001V
         6fzQFuDKieVVG8abK1nGrKYjTu40ngSbafpdugauWMpfgiedSO46L2bFFcXG7y7L1I04
         opjDYViwskmxJCoezaNkE3Hs1nOpUfZqCvbjGLL7Ruqp4lcYO2Nka8k1ZoZXLhIZqwhb
         2rGgugxIczDGSylUrB+FVsqyw2XqvXtgwxy6U7oltTJNPvMsTodzhbRAsbxe32s5qNK5
         LuL8q9ZXVb8CtuUQ60tV8ocUkBF5/VkjaExvJVU5jzxgMtrDyGh3MqrXPDevsrXA7bW4
         k3Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761345289; x=1761950089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dgWMmy8jJ+GexnEc4sqtdfOGQCxpNGU9Ux5BrjtS6oA=;
        b=G9dOOWKxaG6fn+Je2QppyKCoCBZrGLuOtAayBQCet6E94aOHszKWuqrAzPsttozTMH
         WWirYsbmRE37iX1kbPRjU4bCn16RPcIII/AdZfVXg+UM7b3mDEldvVbhQOxuC4stLQJz
         gzI+qWZ7RXEH/UrgpC0kFvGzTU+aLIAHWgxICQnwXlnwHSDBLEhPOpGC/JvqqJqz6qMA
         z3CkBFRHEbvWPVBYotoDGYJ5pLbdjDqEYWw3WZOpjK6g6StVFmF88UsBKo3eNqlsGK2n
         G/vBD/XxzgLN9J6AzyVjJxoTsF/7lC/Vdkv7yXRgGxaV7KCFho9ln1KH2tjcQI2mqRNk
         IRfA==
X-Forwarded-Encrypted: i=1; AJvYcCUJuRMTrX38vVXiGACyVp3h0sEEJz1gEklBABZDyfyhMAtA9PBFRye6rCknT+8jTNhZaTtLNuFecKoOezYo/Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw2l2Oga9b4iTcbuH7GPtLpa5dvKbbpbqbMAAtTnFJV4Dh5hynI
	OVPNHc7Hsz2EeYpGahAc1g5spDlqD8YCXgSHrE4AnER8+78W7j5koEhvTDQkrdzbelqJN1wk7C7
	E9YWJ9y/zU6TJOSOD9/zkTFIHfmjH+fk=
X-Gm-Gg: ASbGncvNXKnB1LvOL7zRjAodDtqZeBljphTim6Y982ZXAEglzq2QtMQzV84QnAstp9V
	L3xH4THjniZZpo0tLbp6cXHCQ+09TC1ZW9MfAVk/zKPH2Qsn1KFPNOHg8sIOymkOsu5fboBWMBD
	h+PGKyd4CeXoKLZW43qt/gGbpUjJEcY1IGzcmFeW2N/IFhril66r7OCS+UaFMgsUDyhsusJFLvo
	Uug46bkA04JAIM0BAnn0n7KIP7cK8kzNWTTsZUObFxxWXn3s3xOOJDA1fKLN7BRHfRbv4LyK0Z5
	nj9lx6AOfuEFDqp4dhBkqCIc0uIV
X-Google-Smtp-Source: AGHT+IGVBqTo1Qga775DM3PeXJFOBVyycwfIPdw/nCiZHEmybAiqSl5amP9rqdkQHIC0hvV9j/gd2HZiroKhtTMd1Iw=
X-Received: by 2002:a05:6000:40c7:b0:427:847:9d59 with SMTP id
 ffacd0b85a97d-42708479e00mr22413715f8f.45.1761345289151; Fri, 24 Oct 2025
 15:34:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251023-sheaves-for-all-v1-0-6ffa2c9941c0@suse.cz> <20251023-sheaves-for-all-v1-3-6ffa2c9941c0@suse.cz>
In-Reply-To: <20251023-sheaves-for-all-v1-3-6ffa2c9941c0@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 24 Oct 2025 15:34:37 -0700
X-Gm-Features: AWmQ_bm73zAZG0hwU9rfMl02lZ4uq3I2SSq2VpZGEnfSrxZZCZEFxDP-C90Ympo
Message-ID: <CAADnVQKYkMVmjMrRhsg29fgYKQU8=bDJW3ghTHLbmFHJPmdNxA@mail.gmail.com>
Subject: Re: [PATCH RFC 03/19] slub: remove CONFIG_SLUB_TINY specific code paths
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
>
> CONFIG_SLUB_TINY minimizes the SLUB's memory overhead in multiple ways,
> mainly by avoiding percpu caching of slabs and objects. It also reduces
> code size by replacing some code paths with simplified ones through
> ifdefs, but the benefits of that are smaller and would complicate the
> upcoming changes.
>
> Thus remove these code paths and associated ifdefs and simplify the code
> base.
>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/slab.h |   2 --
>  mm/slub.c | 107 +++-----------------------------------------------------=
------
>  2 files changed, 4 insertions(+), 105 deletions(-)

Looks like it is removing most of it.
Just remove the whole thing. Do people care about keeping SLUB_TINY?
