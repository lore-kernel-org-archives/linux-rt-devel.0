Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C402C1A9B32
	for <linux-rt-devel@lists.linux.dev>; Wed, 11 Jun 2025 18:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749666031; cv=none; b=DneWPVFJuhgnJ25qhWHkvBJLoJTU6pJO5DO+60Dvv5kgaDeWueWwKO6ttgM8MOBLCembtoNqngfhjTWyz6BjW5AjZyvP1Hk7NwP/7CcYkfax/1q940uuCISPs/dwFMBDYyS165x7yZeumM74tpq2EDyg8diNWGCDUQ9zf0kwibU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749666031; c=relaxed/simple;
	bh=2r7YwymDfWP+8W7dG/+AS2Ig2LS3QJ6Pp9duBEHILUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GHyZzVBchIIIhS0WL1RGZIpjtbuSi76ybDfTlofnlgurq/iLN9l4ayxg7NSL1ZrGPSCA4xcusgiqTPYw7/E0Cesb/YAPwcMU+s0WN4ncUCQatrdwJx0Cs2Gz2oOHtA6eSTQudIIipv0tM2NZZ3SIyx03wWHIYhUNP/TRmBAp3eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M9IMuLj+; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M9IMuLj+"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-450ce3a2dd5so599375e9.3
        for <linux-rt-devel@lists.linux.dev>; Wed, 11 Jun 2025 11:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749666028; x=1750270828; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R5m97eh9RunBN0cr6x3LBcZ++dHF9GYD/OWjDrsIV8A=;
        b=M9IMuLj+F34giFsYZsvMVMa5rMj+/BT5OR3ZTZkXwbHTRVDLDoQuczu1SM/KZ4E0M5
         gS3jxAdKvYG97zw5pVIrILPgVV2SaUtZbPcg1mh1ZpnD3uWBQwydQ/OCGEi/yL1fNYwX
         pVY3PxvjUhjWR5dsPP8ae4IKXpiY+A3KoJzsm9UwpO517EXRrkOCALPVdRSxX/cMM8VL
         1Dzx2IzTt0SOX+0kUSpS+Fjc6IDtlSWxsl5ds/s7lngVKziflmsu9k+J1ToHgMS8OeHf
         i/dwmsipMwsNag20JT6Jvnj1NqxLPfT9p0kMv9yOeeHdCp7lbezN15GzB5p8jwuuM2Kv
         BLdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749666028; x=1750270828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R5m97eh9RunBN0cr6x3LBcZ++dHF9GYD/OWjDrsIV8A=;
        b=a+t6atp5prZO/Miz6dU7vcvH8/17ygm9NNKxfq6jfed5pHCKJDpCdFVoGF0S0BFV/u
         X72fCDcIaZCNuunLtJb4PUhq6SV5Wnlu6YUA98QrzGic4ezVMRwxCOzJ+LvoAhozXkEI
         uTFj6dWHKn7qUe/IgsKKlsWbPNEMuWIjq9unXUdPqWmFvpneifGaqF/BwwV20hiHSp/N
         1Ti7MInvgCU6ivrVaSJk1LZ5E1c9J0erjupTVwT/mtZgmJaTvmBLIDWanaLe4QlIEdn6
         q/wq9JbgRtyRDBIV/2hBnq5jpCRAPoGBs75M6ANU+rIGYIt4Gem2osP9M/QPLOrTRjWU
         yK0w==
X-Forwarded-Encrypted: i=1; AJvYcCU9apymNEGDgW5VV+OboxkiUvgh6U6FE2LyAO2WCnnZXOBLdef8UVSPUE6z6tWXAicjzClPY0T2QXu1xf1ElA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxi2X1bikcsTj2cobYjGc/kVX8+eEzRRTGSweXlHPXgA+s8Idxz
	h1RueZxrDGf9IjOUlNbZJODMGMnljOWim9GnTgGqIJewUhR7116rQZOS4+YOhpjr4+osgVRIbMB
	cSBPmFCIlVwCD2JWkVRfmPSq5lKiNAS7STA==
X-Gm-Gg: ASbGnctfIQmaAEoryB7n1dnp69Y8Yej1w9+lH8UHHEHFYRkdSr98wAWRGF28urckD6S
	iswGswjEmZGlnnLGEln51CE1bBALxID8TnZkKV97jOFTLOpuhd4TtsvMO7tYl+hh1xDNOW5iaqU
	iQCb+JvJCO2z2/zdsJGqQUU0QbTW2nzisOYMAd/r9+C76+dMphvyrgA6TxMiWlcFF45Ha8tS4sz
	TxrMxV5swE=
X-Google-Smtp-Source: AGHT+IFN0T16+CM0BYm4xoqStxnMucus/ObcGvJIdxmQdqT+iYg1rQmwnW8O5aoGCWEdqgZ0XYfEOFl6qW4fzQQV/z4=
X-Received: by 2002:a05:600c:1c81:b0:43d:aed:f7d0 with SMTP id
 5b1f17b1804b1-453248e2bc2mr33035805e9.28.1749666027893; Wed, 11 Jun 2025
 11:20:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAFGhKbwVyxCwYSNrPaQ-GkuP008+uvDg-wNA5syWLLzODCfpcA@mail.gmail.com>
 <68c0649d-d9b3-44f4-9a92-7f72c51a5013@suse.cz>
In-Reply-To: <68c0649d-d9b3-44f4-9a92-7f72c51a5013@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 11 Jun 2025 11:20:16 -0700
X-Gm-Features: AX0GCFsJqwGB-2ewIU3-x1AGG_8a9PCLpm39qmLB1tesuN9NIztbtUp-6xrXsO4
Message-ID: <CAADnVQK+wjvxmBM7WJOGNK=AqeJ7UHBO4tUZR3Gjc4kfgux1sw@mail.gmail.com>
Subject: Re: locking/local_lock, mm: sparse warnings about shadowed variable
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Charlemagne Lasse <charlemagnelasse@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Alexei Starovoitov <ast@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Jakub Kicinski <kuba@kernel.org>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 10:57=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> w=
rote:
>
> On 6/11/25 19:37, Charlemagne Lasse wrote:
> > HI,
> >
> > when I run `make C=3D2 mm/mlock.o CHECK=3D"sparse -Wshadow"`, I get a l=
ot of
> >
> > ./include/linux/local_lock.h:88:1: warning: symbol 'l' shadows an earli=
er one
> > ./include/linux/local_lock.h:88:1: originally declared here
> >
> > after commit
> >
> > 51339d99c0131bc0d16d378e9b05bc498d2967e2 is the first bad commit
> > commit 51339d99c0131bc0d16d378e9b05bc498d2967e2
> > Author: Alexei Starovoitov <ast@kernel.org>
> > Date:   2025-04-02 19:55:14 -0700
> >
> >    locking/local_lock, mm: replace localtry_ helpers with local_trylock=
_t type
>
> Looks like __DEFINE_LOCK_GUARD_1() has "_type *l" and __local_lock_acquir=
e()
> has "local_lock_t *l;". It can be fixed e.g. like this, although it's
> harmless? The _release() part is not necessary, just for symmetry.
>
> diff --git a/include/linux/local_lock_internal.h b/include/linux/local_lo=
ck_internal.h
> index 8d5ac16a9b17..075338f270d0 100644
> --- a/include/linux/local_lock_internal.h
> +++ b/include/linux/local_lock_internal.h
> @@ -97,17 +97,17 @@ do {                                                 =
               \
>  #define __local_lock_acquire(lock)                                     \
>         do {                                                            \
>                 local_trylock_t *tl;                                    \
> -               local_lock_t *l;                                        \
> +               local_lock_t *ll;                                       \

I wouldn't bother messing with the code because of sparse.
Compilers don't warn here.
