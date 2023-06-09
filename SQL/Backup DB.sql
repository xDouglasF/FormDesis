PGDMP     2    6                {            formularioDesis    14.0    14.0 !               0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                       1262    24710    formularioDesis    DATABASE     m   CREATE DATABASE "formularioDesis" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Spanish_Chile.1252';
 !   DROP DATABASE "formularioDesis";
                postgres    false            �            1259    24712 	   candidato    TABLE     j   CREATE TABLE public.candidato (
    idcandidato integer NOT NULL,
    candidato character varying(100)
);
    DROP TABLE public.candidato;
       public         heap    postgres    false            �            1259    24711    candidato_idcandidato_seq    SEQUENCE     �   CREATE SEQUENCE public.candidato_idcandidato_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.candidato_idcandidato_seq;
       public          postgres    false    210                       0    0    candidato_idcandidato_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.candidato_idcandidato_seq OWNED BY public.candidato.idcandidato;
          public          postgres    false    209            �            1259    24726    comuna    TABLE     �   CREATE TABLE public.comuna (
    idcomuna integer NOT NULL,
    comuna character varying(100) NOT NULL,
    idregion integer
);
    DROP TABLE public.comuna;
       public         heap    postgres    false            �            1259    24725    comuna_idcomuna_seq    SEQUENCE     �   CREATE SEQUENCE public.comuna_idcomuna_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.comuna_idcomuna_seq;
       public          postgres    false    214                       0    0    comuna_idcomuna_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.comuna_idcomuna_seq OWNED BY public.comuna.idcomuna;
          public          postgres    false    213            �            1259    24719    region    TABLE     a   CREATE TABLE public.region (
    idregion integer NOT NULL,
    region character varying(100)
);
    DROP TABLE public.region;
       public         heap    postgres    false            �            1259    24718    region_idregion_seq    SEQUENCE     �   CREATE SEQUENCE public.region_idregion_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.region_idregion_seq;
       public          postgres    false    212                       0    0    region_idregion_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.region_idregion_seq OWNED BY public.region.idregion;
          public          postgres    false    211            �            1259    24737    voto    TABLE     C  CREATE TABLE public.voto (
    rut character varying(14) NOT NULL,
    nombre_y_apellido character varying(100) NOT NULL,
    alias character varying(100) NOT NULL,
    email character varying(100) NOT NULL,
    idregion integer,
    idcomuna integer,
    idcandidato integer,
    conocio character varying(50) NOT NULL
);
    DROP TABLE public.voto;
       public         heap    postgres    false            j           2604    24715    candidato idcandidato    DEFAULT     ~   ALTER TABLE ONLY public.candidato ALTER COLUMN idcandidato SET DEFAULT nextval('public.candidato_idcandidato_seq'::regclass);
 D   ALTER TABLE public.candidato ALTER COLUMN idcandidato DROP DEFAULT;
       public          postgres    false    210    209    210            l           2604    24729    comuna idcomuna    DEFAULT     r   ALTER TABLE ONLY public.comuna ALTER COLUMN idcomuna SET DEFAULT nextval('public.comuna_idcomuna_seq'::regclass);
 >   ALTER TABLE public.comuna ALTER COLUMN idcomuna DROP DEFAULT;
       public          postgres    false    213    214    214            k           2604    24722    region idregion    DEFAULT     r   ALTER TABLE ONLY public.region ALTER COLUMN idregion SET DEFAULT nextval('public.region_idregion_seq'::regclass);
 >   ALTER TABLE public.region ALTER COLUMN idregion DROP DEFAULT;
       public          postgres    false    212    211    212                      0    24712 	   candidato 
   TABLE DATA           ;   COPY public.candidato (idcandidato, candidato) FROM stdin;
    public          postgres    false    210   �$                 0    24726    comuna 
   TABLE DATA           <   COPY public.comuna (idcomuna, comuna, idregion) FROM stdin;
    public          postgres    false    214   �$       	          0    24719    region 
   TABLE DATA           2   COPY public.region (idregion, region) FROM stdin;
    public          postgres    false    212   �/                 0    24737    voto 
   TABLE DATA           n   COPY public.voto (rut, nombre_y_apellido, alias, email, idregion, idcomuna, idcandidato, conocio) FROM stdin;
    public          postgres    false    215   �0                  0    0    candidato_idcandidato_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.candidato_idcandidato_seq', 3, true);
          public          postgres    false    209                       0    0    comuna_idcomuna_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.comuna_idcomuna_seq', 44, true);
          public          postgres    false    213                       0    0    region_idregion_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.region_idregion_seq', 15, true);
          public          postgres    false    211            n           2606    24717    candidato candidato_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY public.candidato
    ADD CONSTRAINT candidato_pkey PRIMARY KEY (idcandidato);
 B   ALTER TABLE ONLY public.candidato DROP CONSTRAINT candidato_pkey;
       public            postgres    false    210            r           2606    24731    comuna comuna_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.comuna
    ADD CONSTRAINT comuna_pkey PRIMARY KEY (idcomuna);
 <   ALTER TABLE ONLY public.comuna DROP CONSTRAINT comuna_pkey;
       public            postgres    false    214            p           2606    24724    region region_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.region
    ADD CONSTRAINT region_pkey PRIMARY KEY (idregion);
 <   ALTER TABLE ONLY public.region DROP CONSTRAINT region_pkey;
       public            postgres    false    212            t           2606    24743    voto voto_email_key 
   CONSTRAINT     O   ALTER TABLE ONLY public.voto
    ADD CONSTRAINT voto_email_key UNIQUE (email);
 =   ALTER TABLE ONLY public.voto DROP CONSTRAINT voto_email_key;
       public            postgres    false    215            v           2606    24741    voto voto_pkey 
   CONSTRAINT     M   ALTER TABLE ONLY public.voto
    ADD CONSTRAINT voto_pkey PRIMARY KEY (rut);
 8   ALTER TABLE ONLY public.voto DROP CONSTRAINT voto_pkey;
       public            postgres    false    215            w           2606    24732    comuna comuna_idregion_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.comuna
    ADD CONSTRAINT comuna_idregion_fkey FOREIGN KEY (idregion) REFERENCES public.region(idregion);
 E   ALTER TABLE ONLY public.comuna DROP CONSTRAINT comuna_idregion_fkey;
       public          postgres    false    214    3184    212            z           2606    24754    voto voto_idcandidato_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.voto
    ADD CONSTRAINT voto_idcandidato_fkey FOREIGN KEY (idcandidato) REFERENCES public.candidato(idcandidato);
 D   ALTER TABLE ONLY public.voto DROP CONSTRAINT voto_idcandidato_fkey;
       public          postgres    false    3182    210    215            y           2606    24749    voto voto_idcomuna_fkey    FK CONSTRAINT     ~   ALTER TABLE ONLY public.voto
    ADD CONSTRAINT voto_idcomuna_fkey FOREIGN KEY (idcomuna) REFERENCES public.comuna(idcomuna);
 A   ALTER TABLE ONLY public.voto DROP CONSTRAINT voto_idcomuna_fkey;
       public          postgres    false    214    215    3186            x           2606    24744    voto voto_idregion_fkey    FK CONSTRAINT     ~   ALTER TABLE ONLY public.voto
    ADD CONSTRAINT voto_idregion_fkey FOREIGN KEY (idregion) REFERENCES public.region(idregion);
 A   ALTER TABLE ONLY public.voto DROP CONSTRAINT voto_idregion_fkey;
       public          postgres    false    215    3184    212               <   x�3�tI-N,*���IL�/Rp+��Q.IL��2B�r
��p��)��+���qqq �dm         �
  x�UXKr�H]�N�L @�KI��C�9��=�M,��P��{7G�#h���-.6�e�/Q�����Dn.�o��/
sm;C���y�zm���C��4�i�O��lǐ���7>��ben~��������O���\��9ڞ/6��d#���ly(�r��Bv�v��*/�e?���`�њ�E�4w�o[��4���foC�ˊ�<�v�-�W8��E��6����@m>�>ۺ}��e��mҲ���q�a�׭�))�14�C���hq#�ÔEa^yw�]��b�tɃ�0A����=�A?���M!\���ͮm�\O�ڼ��G�˒��~c>ږ�E����U���`˓k	
s��o�3�%.Mk�,-a۽m�IXAK���	Z�[���0W��k�.�&�P�7�Z]�8?t;w���)���m��,)��'j��%b����a��y� ��8ڽ�]������Deen��Ҿ[\�fuQ�_[�p��妸��6�oBo��v#�~=�ng{�os���u����	g�0[7��ȋ���=� ��4���	v�U�-��(����7h�;�Am����_a7���Z�N���rD���v�c��A�7�Ҽn3,��K�G�K+���"XQ�hz:�D�<]7�6��e�}%���=��8Q����m]/�X������-dg�i�P�@쮕�f����ͼ��/��?��3|C�W8�9NX�4��`-v8�U�5�'��'���c��^ �:r�!�yd�C�H��W�K�f}Q/��$�%R�}��
U'�H�*9,�������0��xw֟D^�+(ǧ�Q������������nn�^^���G^ϰ��Z �<ל-n.�+�9]���g�"�7QA;a-0d�����8�t���b�p�
�^7_��`7e׸8K�J��o��Y,��vB8���*+%�=�)�*�Txm�E��6D�W��ͦ�<8��pȠ3�P�mȮl졍�5��^'�%fm˶���l3�5r�ӟ�Tf��*�.������ct�}TA[�(jC;�E�2Ó�yup�v�[d��Sh�Fyf�е�}������PbݨK���>���;�X][��Ce���:��v�(
$2Go%�r��GT�6t��^Bùt�#8_���q�s���л��/I����>L�c���H���h�T��ڼ
�Մ�6�$� 09���n�@%q��9�q��`I�%J�B~��pS'G�����_;$?07}��$��2u^V�}���X]�A���8)�����ʂ��,��)J	ҏL�yŀ�P+Y����۽ �l��KC��;�,�������ľ�~��ؐ���*�A$��s�=�v>鵢s���A�-r����\' �J�M�h����$�	��`jg��d��'�t� (gӢ{B$��lΔ#�Ѵn�1���seB�k�F�>�������yt�.gZ����icV�v7�-$r�C��_����ń]�N������k�	�����dt�r_P�o�А]�>VX�#�CJ��j�ŝF�y۝P�������ʎ`��o�M�:�D"��5�{�����Q�j�g��R`�w#F�\F�r� �Vp��
���q�b!δ�o�|�xn7鳶���crH�����o���.�ʇ�VY�?)P,���"�_ ��K�s�v��͔�ЬO)�e✙���;ҨHrsO��
�K�Mǁ5�sg��{�4@"�R�_���kTe�#�S#m����m�vg$يl�*TD���@Q�����	�qfL��d��|31[f� a���\IH�����������&���_k���E����!;	�WS�'c/9��X��/���,R�6a�� �$����&�����4��~zD�6��?d���dz��ҝå��xvu��1���4I����䥸;���2z<��y�A��]��������K�o��+"�&�=�~~N��!#)�
F�mB���(g{�Y�a��)9��f(.%(%�Э�,�t0Lhe�������0�C�$��Z��^�8�5i��!����q����=��	ӛjD��A�{@e��B��:�c�>k�Qņ_|@D��'�:Ŭ����H�ȋ�Cs��~T1���;�ehX��Z��~����ɘQ0��ӄ�����F�Y"��먤(pE+q��(��J�ӫ�cnA�I�5[�xV������-*������1��q5U�� v�bP�JN�](X�����Ok�l3�$M���j�#���n�>D`U{�aA0J�4��?@1���Z�(�u�ËR�4��㒄e���&_���5
���p�
k5������S��7��"G�\pEd�{у���K.������r��v)ۉKi�]�G���!W�Dg�X���	Q4�V*�pjfH��!e��&��(ʅ�[�*₃e�'U�<�>Zv�"+��!�^5�+Y�����*D�4`\���]ju�.m��<d���Ѥ\���w�v�[���X�i��lY�"���S�H��Y��@I�6��'��~���@���8�P�&���������y��(��{]��77��VQ.�a团
�ȏ�ޒd)d���(YGQ
қ�����
�� ��R+�QLZ��wt��Rv������r���ۉl��$U�YM���	T&���z#0"������Rg����F�j$��=��C?2�\���|��􏋋��5'      	   �   x�=��N�0�k�S�	���)s) )' �4��K�7�No���
��/�r�hv��QUt=��~Dt=g�F� bF_Vڪ*d~È$΅�2zL����cqS�t�^�gI��t�6G�ٻ� =X���F�kո�ƌ�����Fx��1 ���΍��n���d���qW�Lƨ��Xz�r��j8�'1��I4B!-]*�A���S#z9���Z~��ɫ1��z'��#�$KHe/�����8���6��3"��h;         t   x�32043775�5�t�/M�I,VpK��,HU�M,:�6O�739#5�3 �/*5�#3�Ș3�P/7�(3O/��!=713G/9?�Ӕ�؜Ӑ3<5IG!(5%�X!8?931'��+F��� _�$5     