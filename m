Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7523769E8
	for <linux-rt-devel@lists.linux.dev>; Thu, 21 May 2026 09:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779355083; cv=pass; b=GNP/borITKxI78yefiBo3TlU4oLq5NZyA5uUOV8YMgP1knUgrG07k0D0sx5hRdbq3NuJui7dD7hry6rM/pky9kULbx7cYnNT08EV5u9Ri6Q7bNZaWQ+7g4vbOeIpGgV319iQUKWRFA18xqQG2tlTkuC/OnWrywW8jCdswfAkSpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779355083; c=relaxed/simple;
	bh=vwnfSdJLdKaz9ZvYKHUKW6o9hMPAY38OWs/+ezdVxbA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r15vo0dLwECC5DOuPMG5AUpKjUKgKT5qqIVnbaS6n3ikIC2L9B5mTSK7eiLAYwWh680MOMLREXkVisN9gvnmY1BygKcIlDOVhmdCsz38L35Bh61B0uLi8Ex4ZrPChA/FVTNhv8+vYwuqwaTMeGf1X+ZWALZflC4bi5YA+SGkTF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rcJV+O2k; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rcJV+O2k"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-bda62f13d90so372335566b.2
        for <linux-rt-devel@lists.linux.dev>; Thu, 21 May 2026 02:17:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779355075; cv=none;
        d=google.com; s=arc-20240605;
        b=UybA6XTkEboxnIM1fIueaJV0IUxfSq+3xH+bptbGwh2rDRiG2ToPh/wgjFynE/FzA0
         +jLVaLE9hyIOidwTAsvyDXeVdSrg0oxbYOi5Hujm6XTd2us6Or6Ql2wsQp4AQjZJPyyu
         iZKoO4kJE2HXpW8PmTVKo6wzCCLMXoC0VXyRPFbZX9LNupZW+VVl7Y2qKx/CeHuzDgBS
         zLl5Pqe/hFGgw7JS86JzFZChKPX+/vdwKTN81ooUBH60iwKK53fB8bAfQMGIhN4OfS2U
         feYiJQuuOWZEawTIt/HHxn6VfEjb1gL6D//M1OczS0Qt8WQZUVTuCS8hNnYME0qALcPv
         8pag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dz3+FDOFPvj/C8tgF4g8dO7NJ50HOG7kSmIeflMib8c=;
        fh=wQjiavXtVc9QhooQ605HCKXph/TP33Zupon2n//XscQ=;
        b=aC3z2yZ1Ok/NXmK2dZItD9a/gTw/xU5u3eBZDq4DsjNljePHD2SSToXUFQbCQoe3Vx
         8q2YD4aeRex88GCc3iXIYZpiP4hdaMIdOj89PhzNUthiq2YHOudRo3eYfdVhipqanUHw
         d/lMKX4RgDh7oCkbZ5kgNou9ePFPF8CZKIHj88pHhMpFR4dDEiZYmIthbhwrxeTJJeJw
         5BDyJ4y/vQgBh/WB83whuLUuUpr3aVvJEhJlYveRQiyBcVq6J4VIR565Dx0P8j2pJ2hN
         hPpr5E00LXJK2Zc4/l4NtsZGyJD1vhzx/1KCn7L0qeiPKZJpMaq5W153HxDTfF9TVfkA
         9O7Q==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779355075; x=1779959875; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dz3+FDOFPvj/C8tgF4g8dO7NJ50HOG7kSmIeflMib8c=;
        b=rcJV+O2kbzLulnukOr48FMGgpi8s1priS/CFawmEsxojlVn5laliIfa/hPlBhnIC44
         Qwml+IU6eLP1yU7mqmdSqmnD2ID9aquQs8Jy2SgY5cCc6sfAoNJhHr93CGc5skbFdVKp
         5eKl/CJ4yzutxE5p/SH0WYozSz2kzshmlFi+x4M1BY01IjeDsL4wjS+AHFxNCDUxP4Z7
         bY51+EsIh8TlTVUONcZs1TWR8ZxnmkV9OpqOKft2Tl9fW/PTroZz3QgiFHNvVtRmphEp
         GrN/zZoe8kqpdh4bb09cQdlLFmdeMw8d0QXeyrzyxpRMCDJ0TEuj/CX4x1PEL3+PUvYI
         UITA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779355075; x=1779959875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dz3+FDOFPvj/C8tgF4g8dO7NJ50HOG7kSmIeflMib8c=;
        b=rkjmxAGYZWHg9TzI10CPhSoRcT3bz2LyjfEHvpbEKry9FJVHe95UAA3hjI5mgB5okr
         uDw89DALpiO/s+ruWc1fV9xiiRDv756Qn71DFLWo4PVrZwaS+AS5tmlytko4QYzxLPdz
         PMjOUwNr3ddJxTSnf4+zznEt7GaDQ++Fc/0i8pIPktj7Y0EZddOzIONY1xjQD66XUBRu
         5Tb5IVy9TPxXtV0z9ZvSkv7y7nu9i++JdSB1Pod05B9Sp/iR5Yt0m5WSY5LsPZzA52bA
         fnytxZNwf2xqGVSMFJxXy8sJ73ARIGKYpdmlXjfFYi3mrw6x+mDydarhHswaS3r1H2k8
         UyIQ==
X-Forwarded-Encrypted: i=1; AFNElJ9L+9tx2/2PyssKrrvMrgiEvx3re8xI12GYHJQf2ba9Srz/piSz1UpOo2/BweTO07eg0lNsShuSTVPsMgY+7g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwYDMHYSi9aEAfulkkdrzD1Y3+ZEkxVOaQq+rBvm+mErkc4JQMQ
	AmrVEo9EUzUAW8bGctzTozfVoLbshnxCZ/FjZvTipujvAIuMrZPFCkViPInLO6JenNWyWjJY9Hg
	xytZ0kiLHZYqXYYFGvq9bmlzSB3X7noQ=
X-Gm-Gg: Acq92OEDSCS9le0JEG9pOY9XO2b/6AVVRSLBiCL6EZu2kb6C4i0Sm8cpp7s6zYbA+2h
	JA32CSfJST+dKuVqUN3HdTk4FGAvybZ1jY4cJc1d25jTQoT+gKI/AP/cgB90bZ+TGGkJcXpQCac
	kH1LSVwKymYf8eAYfoYu/9KYorN6jYmnUrp15gbppbb5feah/loT1a7P4WAWMCiICYiSoqHGJCc
	iG6zFY/qLz1YQgBG0KE8oaPfxfi+xFW2pHGsstCQjus7U3ZLAYzinL3iLtL2QyOeSgfGu4niRNh
	4XwAZsC3VVkgXgZyo2ga6gh7gBzoO9t/u5Ax8cQ=
X-Received: by 2002:a17:907:c706:b0:bd6:6f5e:ea6f with SMTP id
 a640c23a62f3a-bdc12f8ce8bmr110244466b.19.1779355074839; Thu, 21 May 2026
 02:17:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260520225245.2962-1-spasswolf@web.de> <fnrz73n5jojl2wlbgrsjdtu5zuwykwbcjzznaijbquuovpoand@i6ihdqn7a6zv>
 <20260521090835.hz0aIRaQ@linutronix.de>
In-Reply-To: <20260521090835.hz0aIRaQ@linutronix.de>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 21 May 2026 11:17:43 +0200
X-Gm-Features: AVHnY4KUqUzhgX_BVVTF4RDqMYY98JVjveuj779cZ0EwzI7KynJ8upkWRPUw0Ic
Message-ID: <CAGudoHH0UHvLapX-DhLR=UGv+E6LwjPA28mdSgZydrnsqQw3wA@mail.gmail.com>
Subject: Re: context switch within RCU read-side critical section in
 next-20260518+ with PREEMPT_RT
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Bert Karwatzki <spasswolf@web.de>, Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-next@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, adobriyan@gmail.com, jack@suse.cz, 
	viro@zeniv.linux.org.uk, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 11:08=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2026-05-21 10:53:03 [+0200], Mateusz Guzik wrote:
> > them in place, but when I was rebasing on top of the RCU-ifing commit I
> > figured I'm going to do guard/scoped_guard in there as well. Later it
> > started failing as the compiler did not like goto retry out of a scoped
> > guard area and the unlocks did not come back.
>
> futex_hash_allocate() has a scoped_guard a goto to again. In case it
> helps.
>

Huh, now I slapped the following for testing purposes and it compiles:
diff --git a/fs/filesystems.c b/fs/filesystems.c
index 771fc31a69b8..d21d264672c5 100644
--- a/fs/filesystems.c
+++ b/fs/filesystems.c
@@ -282,7 +282,7 @@ static __cold noinline int regen_filesystems_string(voi=
d)
        new->len =3D newlen;
        new->string[newlen] =3D '\0';

-       spin_lock(&file_systems_lock);
+       scoped_guard(spinlock, &file_systems_lock) {
        old =3D file_systems_string;

        /*
@@ -320,7 +320,6 @@ static __cold noinline int regen_filesystems_string(voi=
d)
                 * Should never happen of course, keep this in case
someone changes string
                 * generation above and messes it up.
                 */
-               spin_unlock(&file_systems_lock);
                if (old)
                        kfree_rcu(old, rcu);
                return -EINVAL;
@@ -330,7 +329,7 @@ static __cold noinline int regen_filesystems_string(voi=
d)
         * Paired with consume fence in READ_ONCE() in filesystems_proc_sho=
w()
         */
        smp_store_release(&file_systems_string, new);
-       spin_unlock(&file_systems_lock);
+       }
        if (old)
                kfree_rcu(old, rcu);
        return 0;

curious, but ultimately does not matter. I think the current code is a
little better without the guard stuff in this particular place due to
kfree calls.
