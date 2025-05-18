Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED181FFC7B
	for <linux-rt-devel@lists.linux.dev>; Sun, 18 May 2025 09:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747561328; cv=none; b=lIUXvDtgj0wqds4SZRRVYCsAJkkdfLcIR65a5EZLpISJVbJy3h3YcJvu2GTUJgn9vnNR/uL8iP8Wndi17pDQf3UesAq+jwg5H7enq21dgwceTkYCUKtKFgyQaEGoPye/c3bnHZ2QNBYoMKJnAyEep/nH1dlzgGb3Tai+0uD/Kwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747561328; c=relaxed/simple;
	bh=UTFItHpL1Ov817+mrHOFItVvDLlyM44VYdATrQzSa5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iMmFta0lICnUxC3DB9J5vSeps3+49d0jNo+RzLj3JEpzPOpkHjO2hcvGX0SZ8hxRwB7nafrcBhJ54KS8n7uMN7GCYhMwIHlB1nJ7Aa1NoKFmrKvB7WHFULnjESOWIv15+eVGGeAsLe2A3Wqqp0fA0kUIwPzWejdIFgT//8FE2Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ejox/7bS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WLErWH0H; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ejox/7bS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WLErWH0H"
Date: Sun, 18 May 2025 11:42:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747561324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pgvSP/MNLDk7Gd0sGVWO5zEpw8bTN7BrIHK1sH7ZdDQ=;
	b=ejox/7bSSoz2WmTZP3+9cPiCkRriuQyVJrj48VQvETXbHWoTL9O2cQnRozmSibx8tAlG07
	uxJM5iMKqcuIvLwMkV+h5iNsfVOsoINK67fgM+MPnlx3VTIKhNDcJw4Z67dG6mcoHUqdR0
	ZuDhbRtP5pzlEABwQt4sBxawvhuqnsMhUZvqaugplOwXvQCLiaMo6eVHZpHOH9ipjh5gWT
	twCx7Q5JcS+hFYbvCjV0lW/eNVV40CmqAwL6gVadr6SHIAwrB1UhJc6txp8iOr6M7K9FXP
	sNK+73jPbjpt7QfguIm/VeE9VKRupYPMVtgPQD9fbeJqHorsGygy4DaKEK+8Cg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747561324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pgvSP/MNLDk7Gd0sGVWO5zEpw8bTN7BrIHK1sH7ZdDQ=;
	b=WLErWH0Hu+CGZHqsApkN6kgvaMYaPuDE6pkBnOA52Ng11opqaHYuCB0QK97vs0yfhNqK8E
	WDrtDzwM+f3hMdBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-rt-devel@lists.linux.dev,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH 1/2] local_lock: Move this_cpu_ptr() notation from
 internal to main header.
Message-ID: <20250518094202.cVLMUcBN@linutronix.de>
References: <20250514110750.852919-1-bigeasy@linutronix.de>
 <20250514110750.852919-2-bigeasy@linutronix.de>
 <CAADnVQLz=+FN8-B_QmmT-eg7PB7jGHiah=9B-s5WpfmQbAF3eg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAADnVQLz=+FN8-B_QmmT-eg7PB7jGHiah=9B-s5WpfmQbAF3eg@mail.gmail.com>

On 2025-05-14 17:46:43 [-0700], Alexei Starovoitov wrote:
>=20
> Are you sure this is correct?

I hope so.

> Have you tested with gcc 14 or higher?

gcc version 14.2.0 (Debian 14.2.0-19)=20

> It looks to me that moving this_cpu_ptr() up one level should
> still preserve __seg_gs modifier.

If I compile mm/memcontrol.o as-is I get no warnings. Adding

diff --git a/include/linux/local_lock_internal.h b/include/linux/local_lock=
_internal.h
index b4d7b24882835..112324bc362c1 100644
--- a/include/linux/local_lock_internal.h
+++ b/include/linux/local_lock_internal.h
@@ -102,11 +102,11 @@ do {								\
 		l =3D (local_lock_t *)(lock);			\
 		tl =3D (local_trylock_t *)l;				\
 		_Generic((lock),					\
-			local_trylock_t *: ({			\
+			__percpu local_trylock_t *: ({			\
 				lockdep_assert(tl->acquired =3D=3D 0);	\
 				WRITE_ONCE(tl->acquired, 1);		\
 			}),						\
-			local_lock_t *: (void)0);		\
+			__percpu local_lock_t *: (void)0);		\
 		local_lock_acquire(l);					\
 	} while (0)
=20
@@ -171,11 +171,11 @@ do {								\
 		tl =3D (local_trylock_t *)l;				\
 		local_lock_release(l);					\
 		_Generic((lock),					\
-			local_trylock_t *: ({			\
+			__percpu local_trylock_t *: ({			\
 				lockdep_assert(tl->acquired =3D=3D 1);	\
 				WRITE_ONCE(tl->acquired, 0);		\
 			}),						\
-			local_lock_t *: (void)0);		\
+			__percpu local_lock_t *: (void)0);		\
 	} while (0)
=20
 #define __local_unlock(lock)					\

which I assume is what you mean, results in

| In file included from include/linux/preempt.h:11,
|                  from include/linux/spinlock.h:56,
|                  from include/linux/swait.h:7,
|                  from include/linux/completion.h:12,
|                  from include/linux/crypto.h:15,
|                  from arch/x86/kernel/asm-offsets.c:9:
| include/linux/local_lock.h: In function =E2=80=98class_local_lock_destruc=
tor=E2=80=99:
| include/linux/local_lock_internal.h:173:26: error: =E2=80=98_Generic=E2=
=80=99 selector of type =E2=80=98struct <anonymous> *=E2=80=99 is not compa=
tible with any association
|   173 |                 _Generic((lock),                                 =
       \
|       |                          ^
| include/linux/cleanup.h:246:18: note: in definition of macro =E2=80=98DEF=
INE_CLASS=E2=80=99
|   246 | { _type _T =3D *p; _exit; }                                      =
         \
|       |                  ^~~~~
| include/linux/local_lock.h:82:1: note: in expansion of macro =E2=80=98DEF=
INE_GUARD=E2=80=99
|    82 | DEFINE_GUARD(local_lock, local_lock_t __percpu*,
|       | ^~~~~~~~~~~~
| include/linux/local_lock_internal.h:183:17: note: in expansion of macro =
=E2=80=98__local_lock_release=E2=80=99
|   183 |                 __local_lock_release(lock);                     \
|       |                 ^~~~~~~~~~~~~~~~~~~~
| include/linux/local_lock.h:37:41: note: in expansion of macro =E2=80=98__=
local_unlock=E2=80=99
|    37 | #define local_unlock(lock)              __local_unlock(this_cpu_p=
tr(lock))
|       |                                         ^~~~~~~~~~~~~~
| include/linux/local_lock.h:84:14: note: in expansion of macro =E2=80=98lo=
cal_unlock=E2=80=99
|    84 |              local_unlock(_T))
|       |              ^~~~~~~~~~~~
| include/linux/local_lock.h: In function =E2=80=98class_local_lock_constru=
ctor=E2=80=99:
| include/linux/local_lock_internal.h:104:26: error: =E2=80=98_Generic=E2=
=80=99 selector of type =E2=80=98struct <anonymous> *=E2=80=99 is not compa=
tible with any association
|   104 |                 _Generic((lock),                                 =
       \
|       |                          ^
| include/linux/cleanup.h:248:13: note: in definition of macro =E2=80=98DEF=
INE_CLASS=E2=80=99
|   248 | { _type t =3D _init; return t; }
|       |             ^~~~~
| include/linux/local_lock.h:82:1: note: in expansion of macro =E2=80=98DEF=
INE_GUARD=E2=80=99
|    82 | DEFINE_GUARD(local_lock, local_lock_t __percpu*,
|       | ^~~~~~~~~~~~
| include/linux/local_lock_internal.h:116:17: note: in expansion of macro =
=E2=80=98__local_lock_acquire=E2=80=99
|   116 |                 __local_lock_acquire(lock);                     \
|       |                 ^~~~~~~~~~~~~~~~~~~~
| include/linux/local_lock.h:16:41: note: in expansion of macro =E2=80=98__=
local_lock=E2=80=99
|    16 | #define local_lock(lock)                __local_lock(this_cpu_ptr=
(lock))
=E2=80=A6

Sebastian
